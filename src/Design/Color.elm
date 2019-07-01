module Design.Color exposing (black, blue, darkBlue, green, grey, red, transparent, white)

import Element


white =
    Element.rgb 1 1 1


grey =
    Element.rgb 0.9 0.9 0.9


black =
    Element.rgb 0 0 0


transparent =
    Element.rgba 0 0 0 0


blue =
    Element.rgb 0 0 0.8


red =
    Element.rgb255 213 26 52


darkBlue =
    Element.rgb 0 0 0.9


green =
    Element.rgb255 48 176 64
