module Lib.InitApp exposing (Program, application)

import Browser exposing (Document, UrlRequest)
import Browser.Navigation exposing (Key)
import Html
import Url exposing (Url)


type Model flags model msg
    = Initialising flags Url Key (List msg) (Document Never)
    | Ready model


type Msg firstMsg msg
    = Initialise firstMsg
    | MainMsg msg


init :
    (flags -> Url -> Key -> ( Document Never, Cmd firstMsg) )
    -> flags
    -> Url
    -> Key
    -> ( Model flags model msg, Cmd (Msg firstMsg x) )
init initFunc f url key =
    let
        (initView, initCmd) = initFunc f url key
    in
    ( Initialising f url key [] initView
    , Cmd.map Initialise initCmd
    )


update :
    (msg -> model -> ( model, Cmd msg ))
    -> (flags -> Url -> Key -> firstMsg -> ( model, Cmd msg ))
    -> Msg firstMsg msg
    -> Model flags model msg
    -> ( Model flags model msg, Cmd (Msg firstMsg msg) )
update mainUpdate secondInit message mdl =
    let
        crash () =
            update mainUpdate secondInit message mdl
    in
    case message of
        Initialise firstMessage ->
            case mdl of
                Initialising f u k mailbox _ ->
                    List.foldl
                        (\nextMessage ( model, cmd ) ->
                            let
                                ( newModel, newCmd ) =
                                    mainUpdate nextMessage model
                            in
                            ( newModel, Cmd.batch [ cmd, newCmd ] )
                        )
                        (secondInit f u k firstMessage)
                        mailbox
                        |> Tuple.mapFirst Ready
                        |> Tuple.mapSecond (Cmd.map MainMsg)

                Ready _ ->
                    crash ()

        MainMsg mainMsg ->
            case mdl of
                Initialising f u k mailbox initView ->
                    ( Initialising f u k (mainMsg :: mailbox) initView
                    , Cmd.none
                    )

                Ready mainModel ->
                    mainUpdate mainMsg mainModel
                        |> Tuple.mapFirst Ready
                        |> Tuple.mapSecond (Cmd.map MainMsg)


view :
    (model -> Document msg)
    -> Model flags model msg
    -> Document (Msg x msg)
view mainView mdl =
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

        Initialising _ _ _ _ initView ->
            let
                doc =
                    initView
            in
            { body =
                doc.body
                    |> List.map (Html.map never)
            , title = doc.title
            }


subscriptions :
    (model -> Sub msg)
    -> Model flags model msg
    -> Sub (Msg x msg)
subscriptions subscriptionsFunc mdl =
    case mdl of
        Ready mainModel ->
            subscriptionsFunc mainModel
                |> Sub.map MainMsg

        Initialising _ _ _ _ _ ->
            Sub.none


type alias Program flags model initMsg msg =
    Platform.Program flags (Model flags model msg) (Msg initMsg msg)


application :
    { firstInit : flags -> Url -> Key -> ( Document Never, Cmd initMsg )
    , secondInit : flags -> Url -> Key -> initMsg -> ( model, Cmd msg )
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
        , view = view opts.mainView
        , update = update opts.update opts.secondInit
        , subscriptions = subscriptions opts.subscriptions
        , onUrlRequest = opts.onUrlRequest >> MainMsg
        , onUrlChange = opts.onUrlChange >> MainMsg
        }
