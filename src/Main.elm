module Main exposing (main)

import Browser
import Browser.Dom
import Browser.Navigation
import Content.WelshPlaces
import Design.Color as Color
import Dict
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Element.Region as Region
import Html.Attributes
import Lib
import Task
import Url
import Url.Builder
import Url.Parser exposing ((<?>))
import Url.Parser.Query


main =
    Browser.application
        { init = init
        , onUrlRequest = \_ -> Noop
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
    | Noop


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Typing new ->
            ( { model | input = new, place = Lib.waleSearch new }
            , Browser.Navigation.replaceUrl
                model.key
                (Url.Builder.relative [] [ Url.Builder.string "input" new ])
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
                    (\( cost, { name, blurb } ) ->
                        [ Element.el
                            [ Region.heading 2
                            , alignLeft
                            , Font.size 24
                            ]
                            (Element.text (String.fromInt cost ++ ": " ++ name))
                        , Element.el []
                            (Element.paragraph [] [ Element.text blurb ])
                        ]
                    )

        body =
            Element.layout
                [ Font.size 20
                ]
            <|
                Element.column
                    [ width (px 800)
                    , height shrink
                    , centerX
                    , spacing 36
                    , padding 100

                    -- , explain Debug.todo
                    ]
                    ([ el
                        [ Region.heading 1
                        , alignLeft
                        , Font.size 36
                        ]
                        (text "The Welsh Whacker")
                     , Input.text
                        [ Element.htmlAttribute <| Html.Attributes.id "wales-place-input"
                        ]
                        { onChange = Typing
                        , text = model.input
                        , placeholder = Nothing
                        , label = Input.labelLeft [] (Element.text "")
                        }
                     ]
                        ++ infoView
                    )
    in
    { title = "Welsh Whacker"
    , body = [ body ]
    }
