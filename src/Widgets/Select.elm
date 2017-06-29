module Widgets.Select exposing (fromValuesWithLabels)

import Html exposing (Html, select, option, text)
import Html.Attributes exposing (selected)
import Html.Events exposing (onInput)


fromValuesWithLabels : List ( a, String ) -> a -> (a -> msg) -> Html msg
fromValuesWithLabels valuesWithLabels defaultValue msgConstructor =
    let
        optionForTuple ( value, label ) =
            option [ selected (defaultValue == value) ] [ text label ]

        options valuesWithLabels defaultValue =
            List.map optionForTuple valuesWithLabels

        constructMessageForLabel selectedLabel =
            let
                valueAsList =
                    List.filter (\( value, label ) -> label == selectedLabel) valuesWithLabels

                value =
                    case List.head valueAsList of
                        Nothing ->
                            defaultValue

                        Just ( grounds, label ) ->
                            grounds
            in
                msgConstructor value
    in
        select
            [ onInput constructMessageForLabel ]
            (options valuesWithLabels defaultValue)
