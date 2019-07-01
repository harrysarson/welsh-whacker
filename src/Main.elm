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
import Url.Parser exposing ((<?>))
import Url.Parser.Query


main =
    Browser.application
        { init = init
        , onUrlRequest = ClickedLink
        , onUrlChange = \_ -> Noop
        , view = view
        , subscriptions = \_ -> Sub.none
        , update = update
        }


init : () -> Url.Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init () url key =
    let
        input =
            Url.Parser.parse
                urlParser
                url
                |> Maybe.withDefault (Just "")
                |> Maybe.withDefault ""
    in
    ( { input = input
      , place = Lib.waleSearch input
      , key = key
      }
    , Task.attempt (\_ -> Noop) (Browser.Dom.focus "wales-place-input")
    )


urlParser : Url.Parser.Parser (Maybe String -> a) a
urlParser =
    Url.Parser.oneOf [ Url.Parser.top, Url.Parser.s "welsh-whacker" ] <?> Url.Parser.Query.string "input"


type alias Model =
    { input : String
    , place : List ( Int, Content.WelshPlaces.Place )
    , key : Browser.Navigation.Key
    }


type Msg
    = Typing String
    | ClickedLink Browser.UrlRequest
    | Noop


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Typing new ->
            let
                limitted =
                    String.slice 0 25 new
            in
            ( { model | input = limitted, place = Lib.waleSearch limitted }
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

        Noop ->
            ( model, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    let
        infos =
            List.map (Tuple.mapSecond Content.WelshPlaces.getInfo) model.place

        infoView =
            infos
                |> List.concatMap
                    (\( cost, { name, wikipedia } ) ->
                        [ E.el
                            [ Region.heading 2
                            , alignLeft
                            , Font.size 24
                            ]
                            (E.text (String.fromInt cost ++ ": " ++ name))
                        , E.html
                            (Html.iframe
                                [ Html.Attributes.src ("https://en.wikipedia.org/wiki/" ++ wikipedia)
                                , Html.Attributes.style "width" "100%"
                                ]
                                []
                            )
                        ]
                    )

        inputBox =
            E.el
                [ Background.color Color.white
                , Border.rounded 100
                , Border.width 3
                , E.paddingXY padding (padding // 4)
                , E.centerX
                , E.htmlAttribute (Html.Attributes.style "transform" "translateY(-50%)")
                ]
                (Input.text
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
                )

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
                    ([ E.el
                        [ E.width E.fill
                        , E.height (E.px 0)
                        , E.height (E.fillPortion 3)
                        , E.htmlAttribute (Html.Attributes.style "flex-basis" "0")
                        , E.below inputBox
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
                            (text "Welsh Travel Whacker")
                        )
                     , E.column
                        [ E.width E.fill
                        , E.height (E.fillPortion 5)
                        , E.htmlAttribute (Html.Attributes.style "flex-basis" "0")
                        , Background.color Color.green
                        , E.spacing (padding * 2)
                        , E.paddingXY 0 (padding * 3)
                        ]
                        [ E.paragraph
                            [ E.htmlAttribute (Html.Attributes.style "width" "25em")
                            , E.centerX
                            , Font.center
                            , Font.color Color.white
                            , Font.size (fontBase * 4 // 3)
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
                     ]
                     -- ++ infoView
                    )
    in
    { title = "Welsh Whacker"
    , body = [ body ]
    }
