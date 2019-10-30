module Lib.Url exposing (applyUrlToModel, buildUrl)

import Content.WelshPlaces
import Lib
import Lib.Debugging
import Url exposing (Url)
import Url.Builder
import Url.Parser exposing ((<?>))
import Url.Parser.Query


type alias ModelFragment a =
    { a
        | input : String
        , place : Lib.PlaceResult
        , debug : Maybe Lib.Debugging.Info
    }


applyUrlToModel : Url -> ModelFragment a -> ModelFragment a
applyUrlToModel url model =
    let
        { thing, debug } =
            Url.Parser.parse
                urlParser
                url
                |> Maybe.withDefault { thing = Empty, debug = False }

        ( place, debugMatches ) =
            case thing of
                Town t ->
                    Lib.waleSearch t

                _ ->
                    ( Lib.Searching, [] )
    in
    { model
        | input =
            case thing of
                Input i ->
                    i

                _ ->
                    model.input
        , place = place
        , debug =
            if debug then
                Just { matches = Just debugMatches }

            else
                Nothing
    }


type UrlThings
    = Input String
    | Town String
    | Empty


urlParser : Url.Parser.Parser ({ thing : UrlThings, debug : Bool } -> a) a
urlParser =
    Url.Parser.oneOf [ Url.Parser.top, Url.Parser.s "welsh-whacker" ]
        <?> Url.Parser.Query.map3
                (\input town debug ->
                    { thing =
                        input
                            |> Maybe.map Input
                            |> Maybe.withDefault
                                (town
                                    |> Maybe.map Town
                                    |> Maybe.withDefault Empty
                                )
                    , debug =
                        case debug of
                            Just _ ->
                                True

                            Nothing ->
                                False
                    }
                )
                (Url.Parser.Query.string "input")
                (Url.Parser.Query.string "town")
                (Url.Parser.Query.string "debug")


buildUrl : ModelFragment a -> String
buildUrl model =
    Url.Builder.relative []
        ([ Just
            (case model.place of
                Lib.FoundPlace ( _, place ) ->
                    let
                        townName =
                            (Content.WelshPlaces.getInfo place).name
                                |> String.replace " " ""
                    in
                    Url.Builder.string "town" townName

                _ ->
                    Url.Builder.string "input" model.input
            )
         , model.debug
            |> Maybe.map (\_ -> Url.Builder.string "debug" "")
         ]
            |> List.filterMap (\x -> x)
        )
