module Widgets.Select4 exposing (Config, config, view)

import Html exposing (Html, label, option, select, text)
import Html.Attributes exposing (selected)
import Html.Events exposing (onInput)


type alias Options a =
    List ( a, String )


type Config a msg
    = Config (ConfigData a msg)


config : ConfigData a msg -> Config a msg
config =
    Config


type alias ConfigData a msg =
    { label : String
    , defaultValue : a
    , valuesWithLabels : Options a
    , onInput : a -> msg
    }


view : Config a msg -> Html msg
view (Config c) =
    let
        valueFromLabel label =
            case maybeValueFromLabel label of
                Nothing ->
                    c.defaultValue

                Just ( value, _ ) ->
                    value

        maybeValueFromLabel l =
            List.filter (\( value, label ) -> label == l) c.valuesWithLabels
                |> List.head

        optionForTuple ( value, label ) =
            option [ selected (c.defaultValue == value) ] [ text label ]
    in
    label []
        [ text c.label
        , select
            [ onInput (c.onInput << valueFromLabel) ]
            (c.valuesWithLabels |> List.map optionForTuple)
        ]
