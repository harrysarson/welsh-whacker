module Lib.Trie exposing (Trie(..), empty, insert)

import Dict exposing (Dict)


type Trie a
    = Trie (Maybe a) (Dict Char (Trie a))


empty : Trie never
empty =
    Trie Nothing Dict.empty


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
