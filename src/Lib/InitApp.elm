module Lib.InitApp exposing (Program, application)

import Browser exposing (Document, UrlRequest)
import Browser.Navigation exposing (Key)
import Html
import Url exposing (Url)


type Model flags model msg
    = Initialising flags Url Key (List msg)
    | Ready model


type Msg firstMsg msg
    = Initialise firstMsg
    | MainMsg msg


init :
    (flags -> Url -> Key -> Cmd firstMsg)
    -> flags
    -> Url
    -> Key
    -> ( Model flags model msg, Cmd (Msg firstMsg x) )
init initFunc f url key =
    ( Initialising f url key []
    , initFunc f url key
        |> Cmd.map Initialise
    )

specificUpdate :
            (msg -> model -> ( model, Cmd msg ))
            -> (flags -> Url -> Key -> firstMsg -> ( model, Cmd msg ))
            -> Msg firstMsg msg
            -> Model flags model msg
            -> ( model, Cmd msg )
specificUpdate mainUpdate secondInit message mdl =
    let
        crash () =
            specificUpdate mainUpdate secondInit message mdl
    in
    case mdl of
        Initialising f u k mailbox ->
            case message of
                Initialise firstMessage ->
                    List.foldl
                        (\nextMessage (model, cmd) ->
                            let
                                (newModel, newCmd) = mainUpdate nextMessage model
                            in
                                (newModel, Cmd.batch [cmd, newCmd])
                        )
                        (secondInit f u k firstMessage)
                        mailbox

                MainMsg mainMsg ->
                    crash ()

        Ready mainModel ->
            case message of
                Initialise _ ->
                    crash ()

                MainMsg mainMsg ->
                    mainUpdate mainMsg mainModel

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
    case mdl of
        Initialising f u k mailbox ->
            case message of
                Initialise firstMessage ->
                    List.foldl
                        (\nextMessage (model, cmd) ->
                            let
                                (newModel, newCmd) = mainUpdate nextMessage model
                            in
                                (newModel, Cmd.batch [cmd, newCmd])
                        )
                        (secondInit f u k firstMessage)
                        mailbox

                        |> Tuple.mapFirst Ready
                        |> Tuple.mapSecond (Cmd.map MainMsg)

                MainMsg mainMsg ->
                    ( Initialising f u k (mainMsg :: mailbox)
                    , Cmd.none
                    )

        Ready mainModel ->
            case message of
                Initialise _ ->
                    crash ()

                MainMsg mainMsg ->
                    mainUpdate mainMsg mainModel
                        |> Tuple.mapFirst Ready
                        |> Tuple.mapSecond (Cmd.map MainMsg)



view :
    Document Never
    -> (model -> Document msg)
    -> Model flags model msg
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

        Initialising _ _ _ _ ->
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

        Initialising _ _ _ _ ->
            Sub.none


type alias Program flags model initMsg msg =
    Platform.Program flags (Model flags model msg) (Msg initMsg msg)


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
