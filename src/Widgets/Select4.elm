module Widgets.Select4 exposing (Config, config, view)

import Html.Styled exposing (Html, label, option, select, text)
import Html.Styled.Attributes exposing (selected)
import Html.Styled.Events exposing (onInput)


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
view (Config config) =
    let
        valueFromLabel label =
            case maybeValueFromLabel label of
                Nothing ->
                    config.defaultValue

                Just ( value, label ) ->
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
