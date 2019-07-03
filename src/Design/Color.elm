module Design.Color exposing (anchor, black, blue, darkBlue, green, grey, red, transparent, white)

import Element


white : Element.Color
white =
    Element.rgb 1 1 1


anchor : Element.Color
anchor =
    Element.rgb255 176 236 180


grey : Element.Color
grey =
    Element.rgb 0.9 0.9 0.9


black : Element.Color
black =
    Element.rgb 0 0 0


transparent : Element.Color
transparent =
    Element.rgba 0 0 0 0


blue : Element.Color
blue =
    Element.rgb 0 0 0.8


red : Element.Color
red =
    Element.rgb255 213 26 52


darkBlue : Element.Color
darkBlue =
    Element.rgb 0 0 0.9


green : Element.Color
green =
    Element.rgb255 48 176 64
