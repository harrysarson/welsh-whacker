module Content.WelshPlaces exposing (Info, Place(..), getInfo, infoLookup)

import Lib.Trie as Trie
import Dict exposing (Dict)


type Place
    = Cardiff
    | Breakon


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
        Breakon ->
            { name = "Breakon"
            , blurb = """Army training, etc, etc"""
            }


infoLookup : Dict String Place
infoLookup =
    Dict.empty
        |> Dict.insert "Cardiff" Cardiff
        |> Dict.insert "Breakon" Breakon
