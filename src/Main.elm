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
                    Lib.waleSearch t |> List.head

                _ ->
                    Nothing
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


type alias Model =
    { input : String
    , place : Maybe ( Int, Content.WelshPlaces.Place )
    , key : Browser.Navigation.Key
    }


type Msg
    = Typing String
    | ClickedLink Browser.UrlRequest
    | UrlChange Url.Url
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
            ( { model | place = Nothing }
            , case model.place of
                Just _ ->
                    Browser.Navigation.back model.key 1

                Nothing ->
                    Cmd.none
            )

        DoSearch ->
            let
                newPlace =
                    Lib.waleSearch model.input |> List.head
            in
            ( { model | place = newPlace }
            , case newPlace of
                Just ( _, newPlace_ ) ->
                    let
                        newName =
                            (Content.WelshPlaces.getInfo newPlace_).name
                    in
                    Browser.Navigation.pushUrl
                        model.key
                        (Url.Builder.relative [] [ Url.Builder.string "town" newName ])

                Nothing ->
                    Cmd.none
            )

        UrlChange url ->
            init () url model.key

        Noop ->
            ( model, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    let
        town =
            Maybe.map (Tuple.second >> Content.WelshPlaces.getInfo) model.place

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
                [ Background.color Color.white
                , Border.rounded 100
                , Border.width 3
                , Border.color (E.rgb 0 0 0)
                , E.paddingXY padding (padding // 4)
                , E.centerX
                , E.htmlAttribute (Html.Attributes.style "transform" "translateY(-50%)")
                , Font.color (E.rgb 0 0 0)
                ]
                [ Input.text
                    [ E.htmlAttribute <| Html.Attributes.id "wales-place-input"
                    , E.htmlAttribute <| Html.Attributes.style "width" "20em"
                    , Background.color (E.rgba 0 0 0 0)
                    , E.padding 5
                    , Border.width 0
                    , E.focused
                        [ Border.shadow
                            { offset = ( 0, 0 )
                            , size = 0
                            , blur = 0
                            , color = E.rgb 0 0 0
                            }
                        ]
                    , E.height E.fill
                    , Lib.onEnter DoSearch
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
                , Input.button
                    []
                    { label = E.text "Go"
                    , onPress = Just DoSearch
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
                                [ E.image
                                    [ E.htmlAttribute (Html.Attributes.style "transform" "translateY(-20%)")
                                    , E.width (E.px <| padding * 8)
                                    , E.centerX
                                    ]
                                    { description = "todo"
                                    , src = "https://via.placeholder.com/150"
                                    }
                                , E.paragraph
                                    [ E.htmlAttribute (Html.Attributes.style "width" "25em")
                                    , E.centerX
                                    ]
                                    [ E.text town_.blurb
                                    ]
                                , E.column
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
