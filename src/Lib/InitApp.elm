module Lib.InitApp exposing (Application, application, document, element)

import Browser exposing (Document, UrlRequest)
import Browser.Navigation exposing (Key)
import Html exposing (Html)
import Task exposing (Task)
import Url exposing (Url)


type Model initData model msg
    = Initialising initData (List msg)
    | Ready model


type Msg firstMsg msg
    = Initialise firstMsg
    | MainMsg msg


init :
    (initData -> ( view, Task Never firstMsg ))
    -> initData
    -> ( Model (initData, view) model msg, Cmd (Msg firstMsg x) )
init initFunc initData =
    let
        ( initView, initCmd ) =
            initFunc initData
    in
    ( Initialising (initData, initView) []
    , Task.perform Initialise initCmd
    )


update :
    (msg -> model -> ( model, Cmd msg ))
    -> (firstMsg -> initData -> ( model, Cmd msg ))
    -> Msg firstMsg msg
    -> Model initData model msg
    -> ( Model initData model msg, Cmd (Msg firstMsg msg) )
update mainUpdate postInit message mdl =
    let
        crash () =
            update mainUpdate postInit message mdl
    in
    case message of
        Initialise firstMessage ->
            case mdl of
                Initialising initData mailbox ->
                    List.foldl
                        (\nextMessage ( model, cmd ) ->
                            let
                                ( newModel, newCmd ) =
                                    mainUpdate nextMessage model
                            in
                            ( newModel, Cmd.batch [ cmd, newCmd ] )
                        )
                        (postInit firstMessage initData)
                        mailbox
                        |> Tuple.mapFirst Ready
                        |> Tuple.mapSecond (Cmd.map MainMsg)

                Ready _ ->
                    crash ()

        MainMsg mainMsg ->
            case mdl of
                Initialising initData mailbox ->
                    ( Initialising initData (mainMsg :: mailbox)
                    , Cmd.none
                    )

                Ready mainModel ->
                    mainUpdate mainMsg mainModel
                        |> Tuple.mapFirst Ready
                        |> Tuple.mapSecond (Cmd.map MainMsg)


mapDocument : (a -> b) -> Document a -> Document b
mapDocument tagger doc =
    { body =
        doc.body
            |> List.map (Html.map tagger)
    , title = doc.title
    }

view :
    (model -> Document msg)
    -> Model (initData, (Document Never)) model msg
    -> Document (Msg x msg)
view view_ mdl =
    case mdl of
        Ready mainModel ->
            mapDocument MainMsg (view_ mainModel)

        Initialising (_, initView) _ ->
            mapDocument never initView

elView :
    (model -> Html msg)
    -> Model (initData, (Html Never)) model msg
    -> Html (Msg x msg)
elView view_ mdl =
    case mdl of
        Ready mainModel ->
            Html.map MainMsg (view_ mainModel)

        Initialising (_, initView) _ ->
            Html.map never initView



subscriptions :
    (model -> Sub msg)
    -> Model initData model msg
    -> Sub (Msg x msg)
subscriptions subscriptionsFunc mdl =
    case mdl of
        Ready mainModel ->
            subscriptionsFunc mainModel
                |> Sub.map MainMsg

        Initialising _ _ ->
            Sub.none


type alias Application flags model initMsg msg =
    Platform.Program flags (Model (( flags, Url, Key ), (Document Never)) model msg) (Msg initMsg msg)


application :
    { preInit : flags -> Url -> Key -> ( Document Never, Task Never initMsg )
    , postInit : initMsg -> flags -> Url -> Key -> ( model, Cmd msg )
    , view : model -> Document msg
    , update : msg -> model -> ( model, Cmd msg )
    , subscriptions : model -> Sub msg
    , onUrlRequest : UrlRequest -> msg
    , onUrlChange : Url -> msg
    }
    -> Application flags model initMsg msg
application opts =
    Browser.application
        { init = \f u k -> init (\( f_, u_, k_ ) -> opts.preInit f_ u_ k_) ( f, u, k )
        , view =
            view opts.view
        , update = update opts.update (\initMsg (( f, u, k ), _) -> opts.postInit initMsg f u k)
        , subscriptions = subscriptions opts.subscriptions
        , onUrlRequest = opts.onUrlRequest >> MainMsg
        , onUrlChange = opts.onUrlChange >> MainMsg
        }


-- type alias Program flags model initMsg msg =
--     Platform.Program flags (Model flags model msg ) (Msg initMsg msg)


document :
    { preInit : flags -> ( Document Never, Task Never initMsg )
    , postInit : initMsg -> flags -> ( model, Cmd msg )
    , view : model -> Document msg
    , update : msg -> model -> ( model, Cmd msg )
    , subscriptions : model -> Sub msg
    }
    -> Platform.Program flags (Model (flags, (Document Never)) model msg) (Msg initMsg msg)
document opts =
    Browser.document
        { init = init opts.preInit
        , view =
            view opts.view
        , update = update opts.update (\firstMsg (flags, _) -> opts.postInit firstMsg flags)
        , subscriptions = subscriptions opts.subscriptions
        }

element :
    { preInit : flags -> ( Html Never, Task Never initMsg )
    , postInit : initMsg -> flags -> ( model, Cmd msg )
    , view : model -> Html msg
    , update : msg -> model -> ( model, Cmd msg )
    , subscriptions : model -> Sub msg
    }
    -> Platform.Program flags (Model (flags, (Html Never)) model msg) (Msg initMsg msg)
element opts =
    Browser.element
        { init = init opts.preInit
        , view = elView opts.view
        , update = update opts.update (\firstMsg (flags, _) -> opts.postInit firstMsg flags)
        , subscriptions = subscriptions opts.subscriptions
        }
