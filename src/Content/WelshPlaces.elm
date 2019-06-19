module Content.WelshPlaces exposing (Info, Place(..), getInfo, infoLookup)

import Dict exposing (Dict)
import Lib.Trie as Trie


type Place
    = Cardiff
    | Brecon


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


infoLookup : Dict String Place
infoLookup =
    Dict.empty
        |> Dict.insert "Cardiff" Cardiff
        |> Dict.insert "Brecon" Brecon
