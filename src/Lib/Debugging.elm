module Lib.Debugging exposing (Info)

import Content.WelshPlaces


type alias Info =
    { matches : Maybe (List ( Float, Content.WelshPlaces.Place )) }
