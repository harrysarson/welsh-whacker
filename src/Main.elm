module Main exposing (main)

{-| Need to add credits:

  - welsh data
  - <div>Icons made by <a href="https://www.freepik.com/" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/"                 title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/"                 title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>
  - welsh lion: <https://upload.wikimedia.org/wikipedia/commons/1/11/>

-}

import Browser
import Browser.Dom
import Browser.Navigation
import Content.WelshPlaces
import Design.Color as Color
import Design.Icons as Icons
import Dict
import Element as E exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import Element.Region as Region
import Html
import Html.Attributes
import Lib
import Svg
import Svg.Attributes
import Task
import Url
import Url.Builder
import Url.Parser exposing ((</>), (<?>))
import Url.Parser.Query
import Process
import Task

main =
    Browser.application
        { init = init
        , onUrlRequest = ClickedLink
        , onUrlChange = UrlChange
        , view = view
        , subscriptions = \_ -> Sub.none
        , update = update
        }


init : () -> Url.Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init () url key =
    let
        urlThing =
            Url.Parser.parse
                urlParser
                url
                |> Maybe.withDefault Empty
    in
    ( { input =
            case urlThing of
                Input i ->
                    i

                _ ->
                    ""
      , place =
            case urlThing of
                Town t ->
                    search t

                _ ->
                    Searching
      , key = key
      }
    , Task.attempt (\_ -> Noop) (Browser.Dom.focus "wales-place-input")
    )


type UrlThings
    = Input String
    | Town String
    | Empty


urlParser : Url.Parser.Parser (UrlThings -> a) a
urlParser =
    Url.Parser.oneOf [ Url.Parser.top, Url.Parser.s "welsh-whacker" ]
        <?> Url.Parser.Query.map2
                (\input town ->
                    input
                        |> Maybe.withDefault (Maybe.withDefault Empty town)
                )
                (Url.Parser.Query.string "input" |> Url.Parser.Query.map (Maybe.map Input))
                (Url.Parser.Query.string "town" |> Url.Parser.Query.map (Maybe.map Town))

type PlaceResult
    = Searching
    | FoundPlace  ( Int, Content.WelshPlaces.Place )
    | FindingPlace String

type alias Model =
    { input : String
    , place : PlaceResult
    , key : Browser.Navigation.Key
    }


type Msg
    = Typing String
    | ClickedLink Browser.UrlRequest
    | UrlChange Url.Url
    | RequestSearch
    | DoSearch
    | GoToInput
    | Noop


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Typing new ->
            let
                limitted =
                    String.slice 0 25 new
            in
            ( { model | input = limitted }
            , Browser.Navigation.replaceUrl
                model.key
                (Url.Builder.relative [] [ Url.Builder.string "input" limitted ])
            )

        ClickedLink urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Cmd.none
                    )

                Browser.External url ->
                    ( model
                    , Browser.Navigation.load url
                    )

        GoToInput ->
            ( { model | place = Searching }
            , case model.place of
                FoundPlace _ ->
                    Browser.Navigation.back model.key 1

                _ ->
                    Cmd.none
            )

        DoSearch ->
            case model.place of
                FindingPlace str ->
                    let
                        newPlace =
                            search str
                    in
                    ( { model | place = newPlace }
                    , case newPlace of
                        FoundPlace ( _, newPlace_ ) ->
                            let
                                newName =
                                    (Content.WelshPlaces.getInfo newPlace_).name
                            in
                            Browser.Navigation.pushUrl
                                model.key
                                (Url.Builder.relative [] [ Url.Builder.string "town" newName ])

                        _ ->
                            Cmd.none
                    )
                FoundPlace _ -> (model, Cmd.none)
                Searching -> (model, Cmd.none)

        RequestSearch ->
            ( { model | place = FindingPlace model.input }
            , Task.perform (\() -> DoSearch) (Process.sleep 500)
            )

        UrlChange url ->
            init () url model.key

        Noop ->
            ( model, Cmd.none )


type ShowClass
    = Show
    | Hide
    | Hiding


view : Model -> Browser.Document Msg
view model =
    let
        town =
            case model.place of
                FoundPlace (_, place) -> Just (Content.WelshPlaces.getInfo place)
                Searching -> Nothing
                FindingPlace _ -> Nothing

        -- straddledBox =
        --     case town of
        --          town_ ->
        --             E.image
        --                 [ E.htmlAttribute (Html.Attributes.style "transform" "translateY(80%)")
        --                 , E.width (E.px <| padding * 8)
        --                 , E.centerX
        --                 ]
        --                     (E.text (String.fromInt cost ++ ": " ++ name))
        --                 , E.html
        --                     (Html.iframe
        --                         [ Html.Attributes.src ("https://en.wikipedia.org/wiki/" ++ wikipedia)
        --                         , Html.Attributes.style "width" "100%"
        --                         ]
        --                         []
        --                     )
        --                 ]
        --             )

        inputBox =
            E.row
                [ E.htmlAttribute <| Html.Attributes.class "input-box"
                , Background.color Color.white
                , Border.rounded 100
                , Border.width 3
                , Border.color Color.black
                , E.paddingXY padding (padding // 4)
                , E.centerX
                , E.htmlAttribute (Html.Attributes.style "transform" "translateY(-50%)")
                , Font.color Color.black
                ]
                [ Input.text
                    [ E.htmlAttribute <| Html.Attributes.id "wales-place-input"
                    , E.htmlAttribute <| Html.Attributes.style "width" "20em"
                    , Background.color (E.rgba 0 0 0 0)
                    , E.padding 5
                    , Border.color Color.transparent
                    , E.focused
                        [ Border.shadow
                            { offset = ( 0, 0 )
                            , size = 0
                            , blur = 0
                            , color = Color.black
                            }
                        ]
                    , E.height E.fill
                    , Lib.onEnter RequestSearch
                    ]
                    { onChange = Typing
                    , text = model.input
                    , placeholder = Nothing
                    , label =
                        Input.labelLeft
                            []
                            (E.html
                                (Svg.svg
                                    [ Html.Attributes.style "transform" "translateY(0.1em)"
                                    , Svg.Attributes.width "25"
                                    , Svg.Attributes.height "100%"
                                    , Svg.Attributes.viewBox "0 0 512 512"
                                    ]
                                    [ Icons.magnifyingGlass ]
                                )
                            )
                    }
                , let
                    enabled =
                        String.length model.input == 0
                  in
                  Input.button
                    (List.concat
                        [ [ Font.color
                                (if enabled then
                                    Color.grey

                                 else
                                    Color.black
                                )
                          ]
                        , if enabled then
                            [ E.htmlAttribute (Html.Attributes.style "cursor" "text")
                            , E.htmlAttribute (Html.Attributes.style "pointer-events" "none")
                            ]

                          else
                            [ E.pointer ]
                        ]
                    )
                    { label = E.text "Go"
                    , onPress =
                        if enabled then
                            Nothing

                        else
                            Just RequestSearch
                    }
                ]

        padding =
            25

        fontBase =
            16

        body =
            E.layout
                [ Font.size fontBase
                ]
            <|
                E.column
                    [ E.width E.fill
                    , E.height E.fill
                    , E.centerX
                    , E.htmlAttribute <| Html.Attributes.class (case model.place of
                        Searching -> "show"
                        FoundPlace _  -> "hide"
                        FindingPlace _ -> "hiding"
                        )
                    ]
                    [ E.el
                        [ E.width E.fill
                        , E.height (E.px 0)
                        , E.height (E.fillPortion 3)
                        , E.htmlAttribute (Html.Attributes.style "flex-basis" "0")
                        ]
                        (E.el
                            [ Region.heading 1
                            , alignLeft
                            , Font.size (fontBase * 2)
                            , E.centerX
                            , E.alignBottom
                            , E.paddingXY 0 (padding * 3)
                            , Font.color Color.red
                            ]
                            (text
                                (case town of
                                    Just t ->
                                        t.name

                                    Nothing ->
                                        "Welsh Travel Whacker"
                                )
                            )
                        )
                    , E.column
                        [ E.width E.fill
                        , E.height (E.fillPortion 5)
                        , E.htmlAttribute (Html.Attributes.style "flex-basis" "0")
                        , Background.color Color.green

                        -- , E.spacing (padding * 2)
                        , E.spaceEvenly
                        , Font.color Color.white
                        , Font.center
                        , Font.size (fontBase * 4 // 3)

                        -- , E.paddingXY 0 (padding * 3)
                        ]
                        (case town of
                            Just town_ ->
                                List.filterMap identity
                                    [ Just <| E.image
                                        [ E.htmlAttribute (Html.Attributes.style "transform" "translateY(-20%)")
                                        , E.width (E.px <| padding * 8)
                                        , E.height (E.shrink |> E.minimum (padding * 4))
                                        , E.centerX
                                        ]
                                        { description = ""
                                        , src = "https://via.placeholder.com/150"
                                        }
                                    , Just <| E.paragraph
                                        [ E.htmlAttribute (Html.Attributes.style "width" "25em")
                                        , E.centerX
                                        ]
                                        [ E.text town_.blurb
                                        ]
                                    , Just <| E.column
                                        [ E.padding padding
                                        , Events.onClick GoToInput
                                        , E.pointer
                                        ]
                                        [ E.text "Search"
                                        , E.text "Again?"
                                        ]
                                    ]

                            Nothing ->
                                [ inputBox
                                , E.paragraph
                                    [ E.htmlAttribute (Html.Attributes.style "width" "25em")
                                    , E.centerX
                                    ]
                                    [ E.text "Whack your keyboard a couple of times and we will tell you where in Wales you are looking for!"
                                    ]
                                , E.el
                                    [ E.width E.fill ]
                                    (E.html
                                        (Svg.svg
                                            [ Html.Attributes.style "margin" "0 auto"
                                            , Svg.Attributes.width "15em"
                                            , Svg.Attributes.height "100%"
                                            , Svg.Attributes.viewBox "0 0 1000 1000"
                                            ]
                                            [ Icons.welshDragon ]
                                        )
                                    )
                                ]
                        )
                    ]
    in
    { title = "Welsh Whacker"
    , body = [ body ]
    }


search : String -> PlaceResult
search str =
    case Lib.waleSearch str |> List.head of
        Just tuple -> FoundPlace tuple
        Nothing -> Searching