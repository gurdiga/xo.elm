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
        [ text labelText
        , unlabeledTextField defaultValue callback
        ]


unlabeledTextField : String -> (String -> msg) -> Html msg
unlabeledTextField defaultValue callback =
    input
        [ value defaultValue
        , onInput callback
        ]
        []


largeTextField : String -> String -> (String -> msg) -> Html msg
largeTextField labelText defaultValue callback =
    label []
        [ text labelText
        , unlabeledLargeTextField defaultValue callback
        ]


unlabeledLargeTextField : String -> (String -> msg) -> Html msg
unlabeledLargeTextField defaultValue callback =
    textarea
        [ value defaultValue
        , onInput callback
        ]
        []


dateField : String -> MyDate -> (MyDate -> msg) -> Html msg
dateField labelText defaultValue callback =
    let
        { fieldElement, errorMessageElement } =
            unlabeledDateField defaultValue callback
    in
        label []
            [ text labelText
            , fieldElement
            , errorMessageElement
            ]


unlabeledDateField : MyDate -> (MyDate -> msg) -> { fieldElement : Html msg, errorMessageElement : Html msg }
unlabeledDateField defaultValue callback =
    let
        ( inputText, validationMessage ) =
            case MyDate.format defaultValue of
                Ok dateString ->
                    ( dateString, "OK" )

                Err errorMessage ->
                    ( defaultValue.string, errorMessage )
    in
        { fieldElement =
            input
                [ value inputText
                , onInput (\v -> callback (MyDate.parse v))
                ]
                []
        , errorMessageElement = text validationMessage
        }


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

        { amountFieldElement, currencyFieldElement } =
            unlabeledMoneyField money callback
    in
        label []
            [ text labelText
            , amountFieldElement
            , currencyFieldElement
            ]


unlabeledMoneyField : Money -> (Money -> msg) -> { amountFieldElement : Html msg, currencyFieldElement : Html msg }
unlabeledMoneyField (Money amount currency) callback =
    { amountFieldElement =
        input
            [ type_ "number"
            , value (toString amount)
            , onInput (\v -> callback (Money (Result.withDefault 0 (String.toFloat v)) currency))
            ]
            []
    , currencyFieldElement =
        Select.fromValuesWithLabels
            Money.currenciesWithLabels
            currency
            (\v -> callback (Money amount v))
    }
