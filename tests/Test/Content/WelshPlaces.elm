module Test.Content.WelshPlaces exposing (suite)

import Content.WelshPlaces as WP
import Expect
import Lib.Trie
import Test exposing (test)


suite : Test.Test
suite =
    test "size of trie" <|
        \_ ->
            WP.infoLookup
                |> Lib.Trie.size
                |> Expect.equal 28
