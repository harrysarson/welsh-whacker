module Lib exposing (approxSearch)

import Dict
import Lib.Trie exposing (Trie(..))
import List.Nonempty exposing (Nonempty)


construct : a -> List a -> Nonempty a
construct el list =
    List.Nonempty.replaceTail list (List.Nonempty.fromElement el)


approxSearch : String -> Int -> Trie a -> List ( Int, a )
approxSearch word maxCost (Trie maybeValue children) =
    let
        currentRow =
            construct 0 (List.range 1 (String.length word))
    in
    children
        |> Dict.foldl
            (\k v b ->
                approxSearchHelp k word currentRow maxCost v ++ b
            )
            []


approxSearchHelp : Char -> String -> Nonempty Int -> Int -> Trie a -> List ( Int, a )
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
            if ourCost <= maxCost then
                case maybeValue of
                    Just value ->
                        [ ( ourCost, value ) ]

                    Nothing ->
                        []

            else
                []

        checkChildren l child =
            approxSearchHelp l word (List.Nonempty.reverse currentRow) maxCost child
    in
    children
        |> Dict.foldl
            (\k v b ->
                checkChildren k v ++ b
            )
            ourMatch
