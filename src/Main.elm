module Main exposing (main)

{-| Need to add credits:

  - welsh data
  - <div>Icons made by <a href="https://www.freepik.com/" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/"                 title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/"                 title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>
  - welsh lion: <https://upload.wikimedia.org/wikipedia/commons/1/11/>
  - <https://level.app/svg-to-elm>
  - <div>Icons made by <a href="https://www.flaticon.com/authors/good-ware" title="Good Ware">Good Ware</a> from <a href="https://www.flaticon.com/"                 title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/"                 title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>

-}

import Browser
import Browser.Dom
import Browser.Events
import Browser.Navigation
import Content.WelshPlaces
import Design.Color as Color
import Design.Icons as Icons
import Element as E exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import Element.Region as Region
import Html.Attributes
import Html.Events
import Json.Decode
import Lib
import Lib.Debugging
import Lib.InitApp
import Lib.Url
import Svg
import Svg.Attributes
import Task
import Url


type alias ViewportSize =
    { width : Int
    , height : Int
    }


type alias Flags =
    { aberaeron : String
    , aberdyfi : String
    , abergavenny : String
    , aberystwyth : String
    , bala : String
    , betwsyCoed : String
    , blaenauFfestiniog : String
    , blaenavon : String
    , bodelwyddanCastle : String
    , caernarfon : String
    , cardiff : String
    , criccieth : String
    , denbigh : String
    , dolgellau : String
    , kidwelly : String
    , lampeter : String
    , laugharne : String
    , llandovery : String
    , llandudno : String
    , llandysul : String
    , llanfairpwll : String
    , llanfairpwllgwyngyll : String
    , llangefni : String
    , llanrwst : String
    , manorbier : String
    , merthyrTydfil : String
    , nefyn : String
    , newport : String
    , pistyllRhaeadr : String
    , portmeirion : String
    , prestatyn : String
    , pwllheli : String
    , rhossili : String
    , rhyl : String
    , swansea : String
    , tywyn : String
    , ysbytyCynfyn : String
    }


main : Lib.InitApp.ApplicationProgram Flags Model ViewportSize Msg
main =
    Lib.InitApp.application
        { preInit = preInit
        , postInit = postInit
        , onUrlRequest = ClickedLink
        , onUrlChange = UrlChange
        , view = view
        , subscriptions = subscriptions
        , update = update
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ if model.showInfo then
            Browser.Events.onKeyDown (Json.Decode.succeed HideInfo)

          else
            Sub.none
        , Browser.Events.onResize Resize
        ]


preInit :
    Flags
    -> Url.Url
    -> Browser.Navigation.Key
    -> ( Browser.Document Never, Task.Task Never ViewportSize )
preInit _ _ _ =
    ( { body = [], title = "" }
    , Browser.Dom.getViewport
        |> Task.map extractViewport
    )


postInit : ViewportSize -> Flags -> Url.Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
postInit viewport flags url key =
    ( { input = ""
      , place = Nothing
      , key = key
      , showInfo = False
      , viewport = viewport
      , imageUrls = flags
      , debug = Nothing
      }
        |> Lib.Url.applyUrlToModel url
    , Task.attempt (\_ -> Noop) (Browser.Dom.focus "wales-place-input")
    )


type alias Model =
    { input : String
    , place : Maybe ( Float, Content.WelshPlaces.Place )
    , key : Browser.Navigation.Key
    , showInfo : Bool
    , viewport : ViewportSize
    , imageUrls : Flags
    , debug : Maybe Lib.Debugging.Info
    }


type Msg
    = Typing String
    | ClickedLink Browser.UrlRequest
    | UrlChange Url.Url
    | DoSearch
    | GoToInput
    | ShowInfo
    | HideInfo
    | Resize Int Int
    | Noop


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Typing new ->
            let
                limitted =
                    String.slice 0 25 new

                newDebug =
                    Maybe.map
                        (\oldDebug ->
                            let
                                ( _, debugMatches ) =
                                    Lib.walesSearch limitted
                            in
                            { oldDebug
                                | matches = Just debugMatches
                            }
                        )
                        model.debug

                newModel =
                    { model | input = limitted, debug = newDebug }
            in
            ( newModel
            , Browser.Navigation.replaceUrl
                model.key
                (Lib.Url.buildUrl newModel)
            )

        ClickedLink urlRequest ->
            case urlRequest of
                Browser.Internal _ ->
                    ( model
                    , Cmd.none
                    )

                Browser.External url ->
                    ( model
                    , Browser.Navigation.load url
                    )

        GoToInput ->
            -- TODO: consider not pushing URL here if nothing changes
            let
                newModel =
                    { model | place = Nothing }
            in
            ( newModel
            , Browser.Navigation.pushUrl
                model.key
                (Lib.Url.buildUrl newModel)
            )

        DoSearch ->
            let
                ( newPlace, debugMatches ) =
                    Lib.walesSearch model.input

                newDebug =
                    Maybe.map
                        (\oldDebug ->
                            { oldDebug
                                | matches = Just debugMatches
                            }
                        )
                        model.debug

                newModel =
                    { model | place = newPlace, debug = newDebug }
            in
            ( newModel
            , Browser.Navigation.pushUrl
                newModel.key
                (Lib.Url.buildUrl newModel)
            )

        ShowInfo ->
            ( { model | showInfo = True }
            , Cmd.none
            )

        HideInfo ->
            ( { model | showInfo = False }
            , Cmd.none
            )

        UrlChange url ->
            ( Lib.Url.applyUrlToModel url model, Cmd.none )

        Resize width height ->
            ( { model
                | viewport =
                    { width = width
                    , height = height
                    }
              }
            , Cmd.none
            )

        Noop ->
            ( model, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    let
        town =
            Maybe.map (\( _, place ) -> ( Content.WelshPlaces.getInfo place, place )) model.place

        inputBox =
            E.row
                [ E.htmlAttribute <| Html.Attributes.class "input-box"
                , Background.color Color.white
                , Border.rounded 100
                , Border.width 3
                , Border.color Color.black
                , E.paddingXY padding (padding // 4)
                , E.centerX
                , Font.color Color.black
                ]
                [ Input.text
                    [ E.htmlAttribute <| Html.Attributes.id "wales-place-input"
                    , E.htmlAttribute <| Html.Attributes.style "width" (px (baseSize * 20))
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
                                    [ Html.Attributes.style "transform" "translateY(0.2em)"
                                    , Svg.Attributes.width "25"

                                    -- , Svg.Attributes.height "100%"
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
                            Just DoSearch
                    }
                ]

        infoBox =
            let
                lineSpacing =
                    20
            in
            E.el
                [ Events.onClick HideInfo
                , E.width fill
                , E.height fill
                , E.paddingXY 0 (baseSize * 16)
                , Background.color (Lib.setOpacity 0.85 Color.black)
                ]
                (E.row
                    []
                    [ E.el [ E.width (fillPortion 2) ] E.none
                    , E.el
                        [ E.htmlAttribute <| Html.Events.stopPropagationOn "click" (Json.Decode.succeed ( Noop, True ))
                        , E.width (fillPortion 3)
                        , E.height fill
                        , Background.color (Lib.setOpacity 0.9 Color.black)
                        , Border.color Color.white
                        , Border.width (baseSize // 5 + 1)
                        , Border.solid
                        , Font.color Color.grey
                        , E.padding padding
                        ]
                        (E.textColumn
                            [ E.spacing (baseSize * 3 // 2)
                            , Font.size fontBase
                            , E.width fill
                            , E.height fill
                            ]
                            [ E.paragraph
                                [ E.spacing lineSpacing ]
                                [ E.text "The Welsh Whacker is a website built by Harry Sarson and Phillip Gull. The Welsh Whacker is written in "
                                , E.link
                                    [ Font.color Color.anchor ]
                                    { url = "https://elm-lang.org"
                                    , label = E.text "elm"
                                    }
                                , E.text " and the source code is available on "
                                , E.link
                                    [ Font.color Color.anchor ]
                                    { url = "https://github.com/harrysarson/welsh-whacker/"
                                    , label = E.text "github"
                                    }
                                , E.text "."
                                ]
                            , E.paragraph
                                [ E.spacing lineSpacing ]
                                [ E.text "The list of Welsh town names were compiled with help from Paul Stenning's "
                                , E.link
                                    [ Font.color Color.anchor ]
                                    { url = "https://www.paulstenning.com/uk-towns-and-counties-list"
                                    , label = E.text "\"UK Towns and Counties List\""
                                    }
                                , E.text ". The search icon is made by "
                                , E.link
                                    [ Font.color Color.anchor ]
                                    { url = "https://www.freepik.com"
                                    , label = E.text "Freepik"
                                    }
                                , E.text " from "
                                , E.link
                                    [ Font.color Color.anchor ]
                                    { url = "https://www.flaticon.com"
                                    , label = E.text "www.flaticon.com"
                                    }
                                , E.text " and is licensed by "
                                , E.link
                                    [ Font.color Color.anchor ]
                                    { url = "http://creativecommons.org/licenses/by/3.0"
                                    , label = E.text "CC 3.0 BY"
                                    }
                                , E.text ". The information icon is made by "
                                , E.link
                                    [ Font.color Color.anchor ]
                                    { url = "https://www.flaticon.com/authors/good-ware"
                                    , label = E.text "Good Ware"
                                    }
                                , E.text " from "
                                , E.link
                                    [ Font.color Color.anchor ]
                                    { url = "https://www.flaticon.com"
                                    , label = E.text "www.flaticon.com"
                                    }
                                , E.text " and is licensed by "
                                , E.link
                                    [ Font.color Color.anchor ]
                                    { url = "http://creativecommons.org/licenses/by/3.0"
                                    , label = E.text "CC 3.0 BY"
                                    }
                                , E.text ". We are grateful to level for their "
                                , E.link
                                    [ Font.color Color.anchor ]
                                    { url = "https://level.app/svg-to-elm"
                                    , label = E.text "svg-to-elm tool"
                                    }
                                , E.text "."
                                ]

                            -- , E.text (Debug.toString model.viewport)
                            ]
                        )
                    , E.el [ E.width (fillPortion 2) ] E.none
                    ]
                )

        deviceClass =
            (E.classifyDevice model.viewport).class

        padding =
            case deviceClass of
                E.Phone ->
                    25

                E.Tablet ->
                    25

                E.Desktop ->
                    25

                E.BigDesktop ->
                    25

        baseSize =
            case deviceClass of
                E.Phone ->
                    12

                E.Tablet ->
                    12

                E.Desktop ->
                    16

                E.BigDesktop ->
                    16

        fontBase =
            case deviceClass of
                E.Phone ->
                    20

                E.Tablet ->
                    20

                E.Desktop ->
                    20

                E.BigDesktop ->
                    20

        body =
            E.layout
                ([ Just (Font.size fontBase)
                 , Just
                    (Font.family
                        [ Font.typeface "Verdana"
                        , Font.sansSerif
                        ]
                    )
                 , if model.showInfo then
                    Just (E.inFront infoBox)

                   else
                    Nothing
                 ]
                    |> List.filterMap identity
                )
            <|
                E.column
                    [ E.width E.fill
                    , E.height E.fill
                    , E.centerX
                    ]
                    [ let
                        paddingBelowTitle =
                            padding * 3

                        titleFontSize =
                            fontBase * 2
                      in
                      E.el
                        [ E.width E.fill
                        , E.height (E.px (max (baseSize * 9) (paddingBelowTitle * 4 // 3 + titleFontSize)))
                        ]
                        (E.el
                            [ Region.heading 1
                            , alignLeft
                            , Font.size titleFontSize
                            , E.centerX
                            , E.alignBottom
                            , E.paddingEach
                                { top = 0
                                , left = 0
                                , bottom = paddingBelowTitle
                                , right = 0
                                }
                            , Font.color Color.red
                            ]
                            (case town of
                                Just t ->
                                    E.text (Tuple.first t).name

                                Nothing ->
                                    E.html <|
                                        Svg.svg
                                            (Tuple.first Icons.theWelshWhacker <| { width = px (fontBase * 20) })
                                            (Tuple.second Icons.theWelshWhacker)
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
                        , E.paddingEach
                            { top = 0
                            , left = 0
                            , bottom = padding * 2
                            , right = 0
                            }
                        ]
                        (case town of
                            Just town_ ->
                                [ E.image
                                    [ E.htmlAttribute (Html.Attributes.class "town-image")
                                    , E.width (E.px <| baseSize * 24)
                                    , E.height (E.shrink |> E.minimum (padding * 4))
                                    , E.centerX
                                    ]
                                    { description = ""
                                    , src = getImageUrl (Tuple.second town_) model.imageUrls
                                    }
                                , E.paragraph
                                    [ E.width
                                        (case deviceClass of
                                            E.Phone ->
                                                E.fill

                                            _ ->
                                                E.px (baseSize * 35)
                                        )
                                    , E.paddingXY padding 0
                                    , E.centerX
                                    , Font.size fontBase
                                    ]
                                    [ E.text (Tuple.first town_).blurb
                                    ]
                                , E.row
                                    [ E.width E.fill
                                    , E.height E.fill
                                    , E.alignBottom
                                    ]
                                    [ E.el
                                        [ Events.onClick GoToInput
                                        , E.pointer
                                        , E.alignLeft
                                        , E.alignBottom
                                        , E.padding (padding * 2)
                                        ]
                                        (E.html <|
                                            Svg.svg
                                                (Tuple.first Icons.searchAgain <| { width = px (fontBase * 6) })
                                                (Tuple.second Icons.searchAgain)
                                        )
                                    , E.el
                                        [ Events.onClick ShowInfo
                                        , E.pointer
                                        , E.alignRight
                                        , E.alignBottom
                                        , E.padding (padding * 2)
                                        ]
                                        (E.html <|
                                            Svg.svg
                                                (Tuple.first Icons.information <| { width = px (fontBase * 3) })
                                                (Tuple.second Icons.information)
                                        )
                                    ]
                                ]

                            Nothing ->
                                [ inputBox
                                , E.paragraph
                                    [ E.htmlAttribute (Html.Attributes.style "width" (px (baseSize * 25)))
                                    , E.centerX
                                    ]
                                    [ E.text "Whack your keyboard a couple of times and we will tell you where in Wales you are looking for!"
                                    ]
                                , E.el
                                    [ E.width E.fill ]
                                    (case model.debug of
                                        Just debug ->
                                            E.column
                                                [ E.htmlAttribute <| Html.Attributes.style "margin" "0 auto" ]
                                                (debug.matches
                                                    |> Maybe.withDefault []
                                                    |> List.map
                                                        (\m ->
                                                            E.text
                                                                (String.fromFloat (Tuple.first m)
                                                                    ++ ": "
                                                                    ++ (Content.WelshPlaces.getInfo (Tuple.second m)).name
                                                                )
                                                        )
                                                )

                                        Nothing ->
                                            E.el
                                                [ E.htmlAttribute <| Html.Attributes.style "margin" "0 auto" ]
                                                (E.html
                                                    (Svg.svg
                                                        (Tuple.first Icons.welshDragon <| { width = px (fontBase * 15) })
                                                        (Tuple.second Icons.welshDragon)
                                                    )
                                                )
                                    )
                                ]
                        )
                    ]
    in
    { title = "Welsh Whacker"
    , body = [ body ]
    }


extractViewport : Browser.Dom.Viewport -> ViewportSize
extractViewport { viewport } =
    { width = round viewport.width
    , height = round viewport.height
    }


px : Int -> String
px value =
    String.fromInt value ++ "px"


getImageUrl : Content.WelshPlaces.Place -> Flags -> String
getImageUrl place imageUrls =
    case place of
        Content.WelshPlaces.Llandovery ->
            imageUrls.llandovery

        Content.WelshPlaces.Aberaeron ->
            imageUrls.aberaeron

        Content.WelshPlaces.Aberystwyth ->
            imageUrls.aberystwyth

        Content.WelshPlaces.Llandudno ->
            imageUrls.llandudno

        Content.WelshPlaces.Rhyl ->
            imageUrls.rhyl

        Content.WelshPlaces.Bala ->
            imageUrls.bala

        Content.WelshPlaces.BetwsyCoed ->
            imageUrls.betwsyCoed

        Content.WelshPlaces.Caernarfon ->
            imageUrls.caernarfon

        Content.WelshPlaces.Cardiff ->
            imageUrls.cardiff

        Content.WelshPlaces.Pwllheli ->
            imageUrls.pwllheli

        Content.WelshPlaces.Tywyn ->
            imageUrls.tywyn

        Content.WelshPlaces.MerthyrTydfil ->
            imageUrls.merthyrTydfil

        Content.WelshPlaces.Abergavenny ->
            imageUrls.abergavenny

        Content.WelshPlaces.Manorbier ->
            imageUrls.manorbier

        Content.WelshPlaces.PistyllRhaeadr ->
            imageUrls.pistyllRhaeadr

        Content.WelshPlaces.Portmeirion ->
            imageUrls.portmeirion

        Content.WelshPlaces.Rhossili ->
            imageUrls.rhossili

        Content.WelshPlaces.YsbytyCynfyn ->
            imageUrls.ysbytyCynfyn

        Content.WelshPlaces.Llanfairpwllgwyngyll ->
            imageUrls.llanfairpwllgwyngyll

        Content.WelshPlaces.Llangefni ->
            imageUrls.llangefni

        Content.WelshPlaces.Kidwelly ->
            imageUrls.kidwelly

        Content.WelshPlaces.Laugharne ->
            imageUrls.laugharne

        Content.WelshPlaces.Lampeter ->
            imageUrls.lampeter

        Content.WelshPlaces.Llandysul ->
            imageUrls.llandysul

        Content.WelshPlaces.Llanrwst ->
            imageUrls.llanrwst

        Content.WelshPlaces.Denbigh ->
            imageUrls.denbigh

        Content.WelshPlaces.Prestatyn ->
            imageUrls.prestatyn

        Content.WelshPlaces.Nefyn ->
            imageUrls.nefyn
