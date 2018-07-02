module Widgets.Select exposing (unlabeledView, view)

import Html.Styled exposing (Html, label, option, select, span, text)
import Html.Styled.Attributes exposing (selected, style)
import Html.Styled.Events exposing (onInput)
import UI.Styles as Styles


view : String -> List ( a, String ) -> a -> (a -> msg) -> Html msg
view labelText valuesWithLabels defaultValue callback =
    label [ style Styles.inheritFont ]
        [ span [ style Styles.fieldLabel ] [ text labelText ]
        , unlabeledView valuesWithLabels defaultValue callback
        ]


unlabeledView : List ( a, String ) -> a -> (a -> msg) -> Html msg
unlabeledView valuesWithLabels defaultValue callback =
    let
        this =
            select
                [ onInput (callback << valueFromLabel)
                , style Styles.inheritFont
                ]
                (options valuesWithLabels defaultValue)

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
    this
