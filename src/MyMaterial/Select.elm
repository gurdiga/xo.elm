module MyMaterial.Select exposing (view)

import Html exposing (Html, label, select, option, text)
import Html.Attributes exposing (class, selected)
import Html.Events exposing (onInput)


type alias Input msg a =
    { labelText : String
    , valuesWithLabels : List ( a, String )
    , defaultValue : a
    , callback : a -> msg
    }


view : Input msg a -> Html msg
view { labelText, valuesWithLabels, defaultValue, callback } =
    let
        this =
            label []
                [ text labelText
                , select
                    [ class "mdc-select", onInput (callback << valueFromLabel) ]
                    (options valuesWithLabels defaultValue)
                ]

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
