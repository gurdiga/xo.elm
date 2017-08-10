module Widgets.Select exposing (fromValuesWithLabels)

import Html exposing (Html, select, option, text)
import Html.Attributes exposing (selected)
import Html.Events exposing (onInput)


fromValuesWithLabels : List ( a, String ) -> a -> (a -> msg) -> Html msg
fromValuesWithLabels valuesWithLabels defaultValue callback =
    let
        options valuesWithLabels defaultValue =
            List.map optionForTuple valuesWithLabels

        optionForTuple ( value, label ) =
            option [ selected (defaultValue == value) ] [ text label ]

        valueFromLabel label =
            case maybeValueFromLabel label of
                Nothing ->
                    defaultValue

                Just ( value, label ) ->
                    value

        maybeValueFromLabel l =
            List.filter (\( value, label ) -> label == l) valuesWithLabels
                |> List.head
    in
        select
            [ onInput (callback << valueFromLabel) ]
            (options valuesWithLabels defaultValue)
