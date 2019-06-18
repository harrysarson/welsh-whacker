module Main exposing (Model, Msg(..), init, main, search, update, urlParser, view)

{-| -}

import Browser
import Browser.Navigation
import Content.WelshPlaces
import Design.Color as Color
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Element.Region as Region
import Url
import Url.Builder
import Url.Parser exposing ((<?>))
import Url.Parser.Query


main =
    Browser.application
        { init = init
        , onUrlRequest = \_ -> Debug.todo "Handle url request"
        , onUrlChange = UrlChange
        , view = view
        , subscriptions = \_ -> Sub.none
        , update = update
        }


init : () -> Url.Url -> Browser.Navigation.Key -> ( Model, Cmd never )
init () url key =
    let
        input =
            Url.Parser.parse
                urlParser
                url
                |> Maybe.withDefault Nothing
                |> Maybe.withDefault ""
    in
    ( { input = input
      , place = search input
      , key = key
      }
    , Cmd.none
    )


urlParser : Url.Parser.Parser (Maybe String -> a) a
urlParser =
    Url.Parser.top <?> Url.Parser.Query.string "input"


type alias Model =
    { input : String
    , place : Maybe Content.WelshPlaces.Place
    , key : Browser.Navigation.Key
    }


type Msg
    = Typing String
    | UrlChange Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Typing new ->
            ( { model | input = new, place = search new }
            , Browser.Navigation.replaceUrl
                model.key
                (Url.Builder.relative [] [ Url.Builder.string "input" new ])
            )

        UrlChange _ ->
            ( model, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    let
        info =
            Maybe.map Content.WelshPlaces.getInfo model.place

        infoView =
            case info of
                Just { name, blurb } ->
                    [ Element.el []
                        (Element.text name)
                    , Element.el []
                        (Element.paragraph [] [ Element.text blurb ])
                    ]

                Nothing ->
                    []

        body =
            Element.layout
                [ Font.size 20
                ]
            <|
                Element.column [ width (px 800), height shrink, centerY, centerX, spacing 36, padding 10, explain Debug.todo ]
                    ([ el
                        [ Region.heading 1
                        , alignLeft
                        , Font.size 36
                        ]
                        (text "The Welsh Whacker")
                     , Input.text []
                        { onChange = Typing
                        , text = model.input
                        , placeholder = Nothing
                        , label = Input.labelLeft [] (Element.text "Random Characters")
                        }
                     ]
                        ++ infoView
                    )
    in
    { title = "Welsh Whacker"
    , body = [ body ]
    }


search : String -> Maybe Content.WelshPlaces.Place
search word =
    if word == "" then
        Nothing

    else
        Just Content.WelshPlaces.Cardiff
