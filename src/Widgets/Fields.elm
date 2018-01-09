module Widgets.Fields
    exposing
        ( checkboxField
        , largeTextField
        , moneyField
        , textField
        , unlabeledLargeTextField
        , unlabeledMoneyField
        , unlabeledTextField
        )

import Html exposing (Html, input, label, text, textarea)
import Html.Attributes exposing (checked, type_, value)
import Html.Events exposing (onCheck, onInput)
import Utils.Money as Money exposing (Money(..))
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
    , Select.unlabeledView
        Money.currenciesWithLabels
        currency
        (\v -> callback (Money amount v))
    ]
