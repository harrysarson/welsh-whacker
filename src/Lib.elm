module Lib exposing (approxSearch)

import Dict exposing (Dict)
import Lib.Trie exposing (Trie(..))
import List.Nonempty exposing (Nonempty)


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


approxSearch : String -> Int -> Trie a -> List ( Int, a )
approxSearch word maxCost (Trie maybeValue children) =
    let
        currentRow =
            construct 0 (List.range 1 (String.length word))

        matches =
            children
                |> approxSearchFolder
                    word
                    currentRow
                    maxCost
                    { satisfiesCost = []
                    , minimumCost = Nothing
                    }
                |> Debug.log "matches"

    in
    case ( List.isEmpty matches.satisfiesCost, matches.minimumCost ) of
        ( True, Just m ) ->
            [ m ]

        _ ->
            matches.satisfiesCost


type alias ApproxSearchHelpResult a =
    { satisfiesCost : List ( Int, a )
    , minimumCost : Maybe ( Int, a )
    }


approxSearchFolder : String -> Nonempty Int -> Int -> ApproxSearchHelpResult a -> Dict Char (Trie a) -> ApproxSearchHelpResult a
approxSearchFolder word currentRow maxCost initial =
    Dict.foldl
        (\childsLetter child matches ->
            let
                childMatches =
                    approxSearchHelp childsLetter word currentRow maxCost child
            in
            { satisfiesCost = childMatches.satisfiesCost ++ matches.satisfiesCost
            , minimumCost =
                case ( childMatches.minimumCost, matches.minimumCost ) of
                    ( Nothing, Nothing ) ->
                        Nothing

                    ( Just m, Nothing ) ->
                        Just m

                    ( Nothing, Just m ) ->
                        Just m

                    ( Just m1, Just m2 ) ->
                        Just <| minBy Tuple.first m1 m2
            }
        )
        initial


approxSearchHelp : Char -> String -> Nonempty Int -> Int -> Trie a -> ApproxSearchHelpResult a
approxSearchHelp letter word previousRow maxCost (Trie maybeValue children) =
    let
        columns =
            String.length word

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
            { satisfiesCost =
                case ( ourCost <= maxCost, maybeValue ) of
                    ( True, Just value ) ->
                        [ ( ourCost, value ) ]

                    _ ->
                        []
            , minimumCost =
                maybeValue
                    |> Maybe.map (\value -> ( ourCost, value ))
                    |> Debug.log "min"
            }
    in
    if minimum currentRow < maxCost || ourMatch.minimumCost == Nothing then
        children
            |> approxSearchFolder word (List.Nonempty.reverse currentRow) maxCost ourMatch

    else
        ourMatch
