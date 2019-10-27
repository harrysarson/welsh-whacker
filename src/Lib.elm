module Lib exposing (enterDecoder, onEnter, setOpacity, waleSearch)

import Content.WelshPlaces
import Dict
import Element
import Html.Events
import Json.Decode as Decode
import Lib.Trie exposing (Trie(..))
import List.Nonempty exposing (Nonempty)


waleSearch : String -> List ( Int, Content.WelshPlaces.Place )
waleSearch word =
    if word == "" then
        []

    else
        let
            lowerCase =
                String.toLower word
        in
        approxSearch lowerCase (max 4 (String.length word // 3)) Content.WelshPlaces.infoLookup


enterDecoder : msg -> Decode.Decoder msg
enterDecoder msg =
    Decode.field "key" Decode.string
        |> Decode.andThen
            (\key ->
                if key == "Enter" then
                    Decode.succeed msg

                else
                    Decode.fail "Not the enter key"
            )


onEnter : msg -> Element.Attribute msg
onEnter msg =
    Element.htmlAttribute
        (Html.Events.on "keyup" (enterDecoder msg))


setOpacity : Float -> Element.Color -> Element.Color
setOpacity alpha color =
    let
        { red, green, blue } =
            Element.toRgb color
    in
    Element.fromRgb
        { red = red
        , green = green
        , blue = blue
        , alpha = alpha
        }


approxSearch : String -> Int -> Trie a -> List ( Int, a )
approxSearch word maxCost (Trie _ children) =
    let
        firstRow =
            construct 0 (List.range 1 (String.length word))

        matches =
            Dict.foldr
                (approxSearchFolder
                    word
                    firstRow
                    maxCost
                )
                Nothing
                children
    in
    case matches of
        Nothing ->
            []

        Just (MinimumCost m) ->
            [ m ]

        Just (SatisfiesCost ls) ->
            List.sortBy Tuple.first (List.Nonempty.toList ls)


type ApproxSearchHelpResult number a
    = SatisfiesCost (Nonempty ( number, a ))
    | MinimumCost ( number, a )


approxSearchFolder : String -> Nonempty number -> number -> Char -> Trie a -> Maybe (ApproxSearchHelpResult number a) -> Maybe (ApproxSearchHelpResult number a)
approxSearchFolder word currentRow maxCost childsLetter child matches =
    let
        childMatches =
            approxSearchHelp childsLetter word currentRow maxCost child
    in
    case ( childMatches, matches ) of
        ( Nothing, _ ) ->
            matches

        ( _, Nothing ) ->
            childMatches

        ( Just resChild, Just res ) ->
            Just
                (case ( resChild, res ) of
                    ( MinimumCost mChild, MinimumCost m ) ->
                        MinimumCost (minBy Tuple.first mChild m)

                    ( MinimumCost _, SatisfiesCost xs ) ->
                        SatisfiesCost xs

                    ( SatisfiesCost xs, MinimumCost _ ) ->
                        SatisfiesCost xs

                    ( SatisfiesCost xsChild, SatisfiesCost xs ) ->
                        SatisfiesCost (List.Nonempty.append xsChild xs)
                )


approxSearchHelp : Char -> String -> Nonempty number -> number -> Trie a -> Maybe (ApproxSearchHelpResult number a)
approxSearchHelp letter word previousRow maxCost (Trie maybeValue children) =
    let
        getCurrentRow row previous word_ =
            case ( String.uncons word_, List.Nonempty.fromList (List.Nonempty.tail previous) ) of
                ( Just ( wordFirst, wordRest ), Just previousTail ) ->
                    let
                        insertCost =
                            List.Nonempty.head row + 1

                        deleteCost =
                            List.Nonempty.head previousTail + 1

                        replaceCost =
                            List.Nonempty.head previous
                                + (if wordFirst /= letter then
                                    1

                                   else
                                    0
                                  )
                    in
                    getCurrentRow
                        (List.Nonempty.cons
                            (min insertCost (min deleteCost replaceCost))
                            row
                        )
                        previousTail
                        wordRest

                _ ->
                    row

        currentRow =
            getCurrentRow
                (List.Nonempty.fromElement (List.Nonempty.head previousRow + 1))
                previousRow
                word

        ourCost =
            List.Nonempty.head currentRow

        ourMatch =
            maybeValue
                |> Maybe.map
                    (\value ->
                        if ourCost <= maxCost then
                            SatisfiesCost (List.Nonempty.fromElement ( ourCost, value ))

                        else
                            MinimumCost ( ourCost, value )
                    )
    in
    if minimum currentRow < maxCost || ourMatch == Nothing then
        Dict.foldr
            (approxSearchFolder
                word
                (List.Nonempty.reverse currentRow)
                maxCost
            )
            ourMatch
            children

    else
        ourMatch



-- UTILITY --


construct : a -> List a -> Nonempty a
construct el list =
    List.Nonempty.replaceTail list (List.Nonempty.fromElement el)


minimum : Nonempty comparable -> comparable
minimum list =
    case List.minimum (List.Nonempty.tail list) of
        Just minFromTail ->
            min (List.Nonempty.head list) minFromTail

        Nothing ->
            List.Nonempty.head list


minBy : (a -> comparable) -> a -> a -> a
minBy f x y =
    if f x < f y then
        x

    else
        y
