module Content.WelshPlaces exposing (Info, Place(..), getInfo, infoLookup)

import Dict exposing (Dict)
import Lib.Trie as Trie


type Place
    = Cardiff
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
        |> insert "Brecon" Brecon
        |> insert "Kitten" Kitten
