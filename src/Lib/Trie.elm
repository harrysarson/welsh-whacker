module Lib.Trie exposing (Trie(..), empty, insert, size)

import Dict exposing (Dict)


type Trie a
    = Trie (Maybe a) (Dict Char (Trie a))


empty : Trie never
empty =
    Trie Nothing Dict.empty


size : Trie a -> Int
size (Trie value children) =
    Dict.foldr
        (\_ child currentSize -> size child + currentSize)
        (case value of
            Just _ ->
                1

            Nothing ->
                0
        )
        children


insert : String -> a -> Trie a -> Trie a
insert key value (Trie currentValue children) =
    case String.uncons key of
        Just ( first, rest ) ->
            Trie
                currentValue
                (Dict.update
                    first
                    (\maybeChild ->
                        Just <|
                            case maybeChild of
                                Just child ->
                                    insert rest value child

                                Nothing ->
                                    insert rest value empty
                    )
                    children
                )

        Nothing ->
            Trie (Just value) children
