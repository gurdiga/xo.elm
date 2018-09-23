module Widgets.Select exposing (view)

import Html exposing (Html, label, option, select, text)
import Html.Attributes exposing (selected)
import Html.Events exposing (onInput)


type alias Options a =
    List ( a, String )


type alias ConfigData a msg =
    { label : String
    , defaultValue : a
    , valuesWithLabels : Options a
    , onInput : a -> msg
    }


view : ConfigData a msg -> Html msg
view config =
    let
        valueFromLabel label =
            case maybeValueFromLabel label of
                Nothing ->
                    config.defaultValue

                Just ( value, _ ) ->
                    value

        maybeValueFromLabel l =
            List.filter (\( value, label ) -> label == l) config.valuesWithLabels
                |> List.head

        optionForTuple ( value, label ) =
            option [ selected (config.defaultValue == value) ] [ text label ]
    in
    label []
        [ text config.label
        , select
            [ onInput (config.onInput << valueFromLabel) ]
            (config.valuesWithLabels |> List.map optionForTuple)
        ]
