module Content.WelshPlaces exposing (Info, Place(..), getInfo, infoTrie)

import Lib.Trie as Trie


type Place
    = Cardiff


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


infoTrie : Trie.Trie Place
infoTrie =
    Trie.empty
        |> Trie.insert "Cardiff" Cardiff
