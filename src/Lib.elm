module Lib exposing (approxSearch)

import Trie exposing (Trie)


approxSearch : String -> Int -> Trie a -> a
approxSearch word maxCost trie =
    Debug.todo "search"



--     let
--         currentRow = List.range (String.length word)
--     in
--         Debug.todo "search"
--     -- # build first row
--     -- currentRow = range( len(word) + 1 )
--     -- results = []
--     -- # recursively search each branch of the trie
--     -- for letter in trie.children:
--     --     searchRecursive( trie.children[letter], letter, word, currentRow,
--     --         results, maxCost )
--     -- return results
-- approxSearchHelp : Char -> String -> (Int, List Int) -> Int -> Trie a -> a
-- approxSearchHelp letter word previousRow maxCost (Trie maybeValue children) =
--     let
--         columns = List.length word
--         getCurrentRow (rowFirst, rowRest) (previousFirst, previousRest) word_ =
--             case String.uncons word_ of
--                 Just (wordFirst, wordRest) ->
--                     case previousRest of
--                         [] ->
--                             (rowFirst, rowRest)
--                         previousSecond :: newPreviousRest ->
--                             let
--                                 insertCost = rowFirst + 1
--                                 deleteCost = previousSecond + 1
--                                 replaceCost = previousFirst + (if wordFirst == letter then 1 else 0)
--                             in
--                                 getCurrentRow
--                                     (min insertCost (min deleteCost replaceCost), rowFirst :: rowRest)
--                                     (previousSecond, newPreviousRest)
--                                     wordRest
--                 Nothing ->
--                     Debug.todo "Make state impossible"
--         currentRow = getCurrentRow
--             (Tuple.first previousRow + 1, [])
--             previousRow
--             word
--         checkChildren c =
--             approxSearchHelp
--     in
--         if Tuple.first currentRow <= maxCost then
--             case maybeValue of
--                 Just value -> value
--                 Nothing -> checkChildren
--         else
--             checkChildren
