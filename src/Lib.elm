module Lib exposing (enterDecoder, onEnter, setOpacity, waleSearch)

import Content.WelshPlaces
import Dict
import Element
import Html.Events
import Json.Decode as Decode
import Lib.Trie exposing (Trie(..))
import List.Nonempty exposing (Nonempty)


type alias Row =
    { values :
        List
            { cost : Float
            , char : Char
            }
    , index : Float
    }


waleSearch : String -> List ( Float, Content.WelshPlaces.Place )
waleSearch word =
    if word == "" then
        []

    else
        let
            lowerCase =
                String.toLower word
        in
        approxSearch lowerCase (max 6 (toFloat (String.length word) / 3)) Content.WelshPlaces.infoLookup


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


approxSearch : String -> Float -> Trie a -> List ( Float, a )
approxSearch word maxCost (Trie _ children) =
    let
        firstRow =
            { values =
                word
                    |> String.toList
                    |> List.indexedMap (\i c -> { cost = toFloat i + 1, char = c })
            , index = 0
            }

        matches =
            Dict.foldr
                (approxSearchFolder
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


type ApproxSearchHelpResult a
    = SatisfiesCost (Nonempty ( Float, a ))
    | MinimumCost ( Float, a )


approxSearchFolder : Row -> Float -> Char -> Trie a -> Maybe (ApproxSearchHelpResult a) -> Maybe (ApproxSearchHelpResult a)
approxSearchFolder currentRow maxCost childsLetter child matches =
    let
        childMatches =
            approxSearchHelp childsLetter currentRow maxCost child
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


approxSearchHelp : Char -> Row -> Float -> Trie a -> Maybe (ApproxSearchHelpResult a)
approxSearchHelp letter previousRow maxCost (Trie maybeValue children) =
    let
        getCurrentRow : Row -> List { cost : Float, char : Char }
        getCurrentRow previous =
            getCurrentRowHelp
                curentRowIndex
                []
                previous.index
                previous.values

        getCurrentRowHelp : Float -> List { cost : Float, char : Char } -> Float -> List { cost : Float, char : Char } -> List { cost : Float, char : Char }
        getCurrentRowHelp index row firstPreviousCost previous =
            case previous of
                previous0 :: previousTail ->
                    let
                        wordFirst =
                            previous0.char

                        deleteCost =
                            (row
                                |> List.head
                                |> Maybe.map .cost
                                |> Maybe.withDefault index
                            )
                                + 1

                        insertCost =
                            previous0.cost + 0.26

                        replaceCost =
                            firstPreviousCost
                                + (if wordFirst /= letter then
                                    1

                                   else
                                    0
                                  )
                    in
                    getCurrentRowHelp
                        index
                        ({ cost = min insertCost (min deleteCost replaceCost)
                         , char = wordFirst
                         }
                            :: row
                        )
                        previous0.cost
                        previousTail

                _ ->
                    row

        curentRowIndex =
            previousRow.index + 1

        currentRowReversed =
            getCurrentRow
                previousRow

        ourCost =
            currentRowReversed
                |> List.head
                |> Maybe.map .cost
                |> Maybe.withDefault curentRowIndex

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
    if List.foldl min curentRowIndex (List.map .cost currentRowReversed) < maxCost || ourMatch == Nothing then
        Dict.foldr
            (approxSearchFolder
                { values = List.reverse currentRowReversed
                , index = curentRowIndex
                }
                maxCost
            )
            ourMatch
            children

    else
        ourMatch



-- UTILITY --


minBy : (a -> comparable) -> a -> a -> a
minBy f x y =
    if f x < f y then
        x

    else
        y
