module Widgets.Fields
    exposing
        ( textField
        , unlabeledTextField
        , largeTextField
        , unlabeledLargeTextField
        , dateField
        , unlabeledDateField
        , checkboxField
        , moneyField
        , unlabeledMoneyField
        )

import Html exposing (Html, label, input, textarea, text)
import Html.Attributes exposing (value, checked, type_)
import Html.Events exposing (onInput, onCheck)
import MyDate exposing (MyDate)
import Money exposing (Money(..))
import Widgets.Select as Select


textField : String -> String -> (String -> msg) -> Html msg
textField labelText defaultValue callback =
    label []
        (text labelText
            :: unlabeledTextField defaultValue callback
        )


unlabeledTextField : String -> (String -> msg) -> List (Html msg)
unlabeledTextField defaultValue callback =
    [ input
        [ value defaultValue
        , onInput callback
        ]
        []
    ]


largeTextField : String -> String -> (String -> msg) -> Html msg
largeTextField labelText defaultValue callback =
    label []
        (text labelText
            :: unlabeledLargeTextField defaultValue callback
        )


unlabeledLargeTextField : String -> (String -> msg) -> List (Html msg)
unlabeledLargeTextField defaultValue callback =
    [ textarea
        [ value defaultValue
        , onInput callback
        ]
        []
    ]


dateField : String -> MyDate -> (MyDate -> msg) -> Html msg
dateField labelText defaultValue callback =
    label []
        (text labelText
            :: unlabeledDateField defaultValue callback
        )


unlabeledDateField : MyDate -> (MyDate -> msg) -> List (Html msg)
unlabeledDateField defaultValue callback =
    let
        ( inputText, validationMessage ) =
            case MyDate.format defaultValue of
                Ok dateString ->
                    ( dateString, "OK" )

                Err errorMessage ->
                    ( defaultValue.string, errorMessage )
    in
        [ input
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
moneyField labelText money callback =
    let
        (Money amount currency) =
            money
    in
        label []
            (text labelText
                :: unlabeledMoneyField money callback
            )


unlabeledMoneyField : Money -> (Money -> msg) -> List (Html msg)
unlabeledMoneyField (Money amount currency) callback =
    [ input
        [ type_ "number"
        , value (toString amount)
        , onInput (\v -> callback (Money (Result.withDefault 0 (String.toFloat v)) currency))
        ]
        []
    , Select.fromValuesWithLabels
        Money.currenciesWithLabels
        currency
        (\v -> callback (Money amount v))
    ]
