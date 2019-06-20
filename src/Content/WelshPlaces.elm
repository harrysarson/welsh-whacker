module Content.WelshPlaces exposing (Info, Place(..), getInfo, infoLookup)

import Dict exposing (Dict)
import Lib.Trie as Trie


type Place
    = Cardiff
    | Cardiff2
    | Brecon
    | Kitten


type alias Info =
    { name : String
    , blurb : String
    }


getInfo : Place -> Info
getInfo place =
    case place of
        Cardiff ->
            { name = "Cardiff"
            , blurb = """The capital of Wales, etc, etc"""
            }

        Brecon ->
            { name = "Brecon"
            , blurb = """Army training, etc, etc"""
            }

        Kitten ->
            { name = "Kitten"
            , blurb = """NOT A WELSH PLACE!"""
            }

        Cardiff2 ->
            { name = "Cardiff2"
            , blurb = """NOT A Cardiff PLACE!"""
            }


infoLookup : Trie.Trie Place
infoLookup =
    let
        empty =
            Trie.empty

        insert =
            Trie.insert
    in
    empty
        |> insert "Cardiff" Cardiff
        |> insert "Cardiff2" Cardiff2
        |> insert "Brecon" Brecon
        |> insert "Kitten" Kitten
