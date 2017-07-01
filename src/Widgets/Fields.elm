module Widgets.Fields exposing (textField, largeTextField, dateField, checkboxField, moneyField, fileField)

import Html exposing (Html, label, input, textarea, text)
import Html.Attributes exposing (value, checked, type_)
import Html.Events exposing (on, onInput, onCheck)
import Json.Decode as Json
import MyDate exposing (MyDate)
import Money exposing (Money(..))
import Widgets.Select as Select


textField : String -> String -> (String -> msg) -> Html msg
textField labelText defaultValue callback =
    label []
        [ text labelText
        , input
            [ value defaultValue
            , onInput callback
            ]
            []
        ]


largeTextField : String -> String -> (String -> msg) -> Html msg
largeTextField labelText defaultValue callback =
    label []
        [ text labelText
        , textarea
            [ value defaultValue
            , onInput callback
            ]
            []
        ]


dateField : String -> MyDate -> (MyDate -> msg) -> Html msg
dateField labelText defaultValue callback =
    let
        ( inputText, validationMessage ) =
            case MyDate.format defaultValue of
                Ok dateString ->
                    ( dateString, "OK" )

                Err errorMessage ->
                    ( defaultValue.string, errorMessage )
    in
        label []
            [ text labelText
            , input
                [ value inputText
                , onInput (\v -> callback (MyDate.parse v))
                ]
                []
            , text validationMessage
            ]


checkboxField : String -> Bool -> (Bool -> msg) -> Html msg
checkboxField labelText isChecked callback =
    label []
        [ input
            [ type_ "checkbox"
            , checked isChecked
            , onCheck callback
            ]
            []
        , text labelText
        ]


moneyField : String -> Money -> (Money -> msg) -> Html msg
moneyField labelText (Money amount currency) callback =
    label []
        [ text labelText
        , input
            [ type_ "number"
            , value (toString amount)
            , onInput (\v -> callback (Money (Result.withDefault 0 (String.toFloat v)) currency))
            ]
            []
        , Select.fromValuesWithLabels Money.currenciesWithLabels
            currency
            (\v -> callback (Money amount v))
        ]


fileField : String -> (String -> msg) -> Html msg
fileField labelText callback =
    label []
        [ text labelText
        , input
            [ type_ "file"
            , onFileSelect callback
            ]
            []
        ]


onFileSelect : (String -> msg) -> Html.Attribute msg
onFileSelect callback =
    on "change" (Json.map (\v -> callback (Debug.log "calling back with" v)) filePath)


filePath : Json.Decoder String
filePath =
    Json.at [ "target", "value" ] Json.string
