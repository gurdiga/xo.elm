module Widgets.Select exposing (view, unlabeledView)

import Html exposing (Html, label, select, option, span, text)
import Html.Attributes exposing (style, selected)
import Html.Events exposing (onInput)
import UI.Styles as Styles


view : String -> List ( a, String ) -> a -> (a -> msg) -> Html msg
view labelText valuesWithLabels defaultValue callback =
    label []
        [ span [ style Styles.fieldLabel ] [ text labelText ]
        , unlabeledView valuesWithLabels defaultValue callback
        ]


unlabeledView : List ( a, String ) -> a -> (a -> msg) -> Html msg
unlabeledView valuesWithLabels defaultValue callback =
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
