module Lib exposing (enterDecoder, onEnter, setOpacity, waleSearch)

import Content.WelshPlaces
import Dict exposing (Dict)
import Element
import Html.Events
import Json.Decode as Decode
import Lib.Trie exposing (Trie(..))
import List.Nonempty exposing (Nonempty)


waleSearch : String -> List ( Int, Content.WelshPlaces.Place )
waleSearch word =
    if word == "" then
        []

    else
        let
            lowerCase =
                String.toLower word
        in
        approxSearch lowerCase (max 4 (String.length word // 3)) Content.WelshPlaces.infoLookup


enterDecoder : msg -> Decode.Decoder msg
enterDecoder msg =
    Decode.field "key" Decode.string
        |> Decode.andThen
            (\key ->
                if key == "Enter" then
                    Decode.succeed msg

                else
                    Decode.fail "Not the enter key"
            )


onEnter : msg -> Element.Attribute msg
onEnter msg =
    Element.htmlAttribute
        (Html.Events.on "keyup" (enterDecoder msg))


setOpacity : Float -> Element.Color -> Element.Color
setOpacity alpha color =
    let
        { red, green, blue } =
            Element.toRgb color
    in
    Element.fromRgb
        { red = red
        , green = green
        , blue = blue
        , alpha = alpha
        }


approxSearch : String -> Int -> Trie a -> List ( Int, a )
approxSearch word maxCost (Trie _ children) =
    let
        currentRow =
            construct 0 (List.range 1 (String.length word))

        matches =
            children
                |> approxSearchFolder
                    word
                    currentRow
                    maxCost
                    Nothing
    in
    case matches of
        Nothing ->
            []

        Just (MinimumCost m) ->
            [ m ]

        Just (SatisfiesCost ls) ->
            List.sortBy Tuple.first (List.Nonempty.toList ls)


type ApproxSearchHelpResult a
    = SatisfiesCost (Nonempty ( Int, a ))
    | MinimumCost ( Int, a )


approxSearchFolder : String -> Nonempty Int -> Int -> Maybe (ApproxSearchHelpResult a) -> Dict Char (Trie a) -> Maybe (ApproxSearchHelpResult a)
approxSearchFolder word currentRow maxCost initial =
    Dict.foldl
        (\childsLetter child matches ->
            let
                childMatches =
                    approxSearchHelp childsLetter word currentRow maxCost child
            in
            case ( childMatches, matches ) of
                ( Nothing, _ ) ->
                    matches

                ( _, Nothing ) ->
                    childMatches

                ( Just resChild, Just res ) ->
                    Just
                        (case ( resChild, res ) of
                            ( MinimumCost mChild, MinimumCost m ) ->
                                MinimumCost (minBy Tuple.first mChild m)

                            ( MinimumCost _, SatisfiesCost xs ) ->
                                SatisfiesCost xs

                            ( SatisfiesCost xs, MinimumCost _ ) ->
                                SatisfiesCost xs

                            ( SatisfiesCost xsChild, SatisfiesCost xs ) ->
                                SatisfiesCost (List.Nonempty.append xsChild xs)
                        )
        )
        initial


approxSearchHelp : Char -> String -> Nonempty Int -> Int -> Trie a -> Maybe (ApproxSearchHelpResult a)
approxSearchHelp letter word previousRow maxCost (Trie maybeValue children) =
    let
        getCurrentRow row previous word_ =
            -- let
            --     -- _ = Debug.log "prev" previous
            --     -- _ = Debug.log "words" word_
            -- in
            case String.uncons word_ of
                -- (Debug.log "word_" word_) of
                Just ( wordFirst, wordRest ) ->
                    case List.Nonempty.fromList (List.Nonempty.tail previous) of
                        Just previousTail ->
                            let
                                insertCost =
                                    -- Debug.log+ "ic"
                                    List.Nonempty.head row + 1

                                deleteCost =
                                    -- Debug.log "dc"
                                    List.Nonempty.head previousTail + 1

                                replaceCost =
                                    -- Debug.log "rc"
                                    List.Nonempty.head previous
                                        + (if wordFirst /= letter then
                                            1

                                           else
                                            0
                                          )

                                -- _ =
                                --     Debug.log "l w" ( letter, wordFirst, wordRest )
                            in
                            getCurrentRow
                                (List.Nonempty.cons
                                    (min insertCost (min deleteCost replaceCost))
                                    row
                                )
                                previousTail
                                wordRest

                        Nothing ->
                            row

                Nothing ->
                    -- Debug.log "Make state impossible 2"
                    row

        currentRow =
            -- Debug.log "current row" <|
            getCurrentRow
                (List.Nonempty.fromElement (List.Nonempty.head previousRow + 1))
                previousRow
                -- (Debug.log "prev row ip" <| previousRow)
                word

        ourCost =
            List.Nonempty.head currentRow

        ourMatch =
            maybeValue
                |> Maybe.map
                    (\value ->
                        if ourCost <= maxCost then
                            SatisfiesCost (List.Nonempty.fromElement ( ourCost, value ))

                        else
                            MinimumCost ( ourCost, value )
                    )
    in
    if minimum currentRow < maxCost || ourMatch == Nothing then
        children
            |> approxSearchFolder word (List.Nonempty.reverse currentRow) maxCost ourMatch

    else
        ourMatch



-- UTILITY --


construct : a -> List a -> Nonempty a
construct el list =
    List.Nonempty.replaceTail list (List.Nonempty.fromElement el)


minimum : Nonempty comparable -> comparable
minimum list =
    case List.minimum (List.Nonempty.tail list) of
        Just minFromTail ->
            min (List.Nonempty.head list) minFromTail

        Nothing ->
            List.Nonempty.head list


minBy : (a -> comparable) -> a -> a -> a
minBy f x y =
    if f x < f y then
        x

    else
        y
