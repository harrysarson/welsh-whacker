module Lib.InitApp exposing (Program, application)

import Browser exposing (Document, UrlRequest)
import Browser.Navigation exposing (Key)
import Html
import Url exposing (Url)


type Model flags model
    = Initialising flags Url Key
    | Ready model


type Msg firstMsg msg
    = Initialised firstMsg
    | MainMsg msg
    | Dummy


init :
    (flags -> Url -> Key -> Cmd firstMsg)
    -> flags
    -> Url
    -> Key
    -> ( Model flags model, Cmd (Msg firstMsg x) )
init initFunc f url key =
    ( Initialising f url key
    , initFunc f url key
        |> Cmd.map Initialised
    )


update :
    (msg -> model -> ( model, Cmd msg ))
    -> (flags -> Url -> Key -> firstMsg -> ( model, Cmd msg ))
    -> Msg firstMsg msg
    -> Model flags model
    -> ( Model flags model, Cmd (Msg firstMsg msg) )
update mainUpdate secondInit message mdl =
    let
        crash _ =
            -- let
            --     _ = Debug.log "invalid message" message
            --     _ = Debug.log "invalid mdl" mdl
            -- in
            update mainUpdate secondInit message mdl
    in
    case mdl of
        Initialising f u k ->
            case message of
                Initialised firstMessage ->
                    secondInit f u k firstMessage
                        |> Tuple.mapFirst Ready
                        |> Tuple.mapSecond (Cmd.map MainMsg)

                MainMsg _ ->
                    crash ()

                Dummy ->
                    crash ()

        Ready mainModel ->
            case message of
                Initialised _ ->
                    crash ()

                MainMsg mainMsg ->
                    mainUpdate mainMsg mainModel
                        |> Tuple.mapFirst Ready
                        |> Tuple.mapSecond (Cmd.map MainMsg)

                Dummy ->
                    crash ()


view :
    Document Never
    -> (model -> Document msg)
    -> Model flags model
    -> Document (Msg x msg)
view initView mainView mdl =
    case mdl of
        Ready mainModel ->
            let
                doc =
                    mainView mainModel
            in
            { body =
                doc.body
                    |> List.map (Html.map MainMsg)
            , title = doc.title
            }

        Initialising _ _ _ ->
            let
                doc =
                    initView
            in
            { body =
                doc.body
                    |> List.map (Html.map (\_ -> Dummy))
            , title = doc.title
            }


subscriptions :
    (model -> Sub msg)
    -> Model flags model
    -> Sub (Msg x msg)
subscriptions subscriptionsFunc mdl =
    case mdl of
        Ready mainModel ->
            subscriptionsFunc mainModel
                |> Sub.map MainMsg

        Initialising _ _ _ ->
            Sub.none


type alias Program flags model initMsg msg =
    Platform.Program flags (Model flags model) (Msg initMsg msg)


application :
    { firstInit : flags -> Url -> Key -> Cmd initMsg
    , secondInit : flags -> Url -> Key -> initMsg -> ( model, Cmd msg )
    , initView : Document Never
    , mainView : model -> Document msg
    , update : msg -> model -> ( model, Cmd msg )
    , subscriptions : model -> Sub msg
    , onUrlRequest : UrlRequest -> msg
    , onUrlChange : Url -> msg
    }
    -> Program flags model initMsg msg
application opts =
    Browser.application
        { init = init opts.firstInit
        , view = view opts.initView opts.mainView
        , update = update opts.update opts.secondInit
        , subscriptions = subscriptions opts.subscriptions
        , onUrlRequest = opts.onUrlRequest >> MainMsg
        , onUrlChange = opts.onUrlChange >> MainMsg
        }
