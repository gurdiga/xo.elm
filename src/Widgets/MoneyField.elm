module Widgets.MoneyField exposing (Msg, initialModel, update, view)

import Html exposing (Html, input, label, text)
import Html.Attributes exposing (type_, value)
import Html.Events exposing (onInput)
import Utils.Money as Money exposing (Currency(..), Money(..))
import Widgets.Select as Select


initialModel : Money
initialModel =
    Money 0 MDL


type Msg
    = SetAmount String
    | SetCurrency Currency


update : Msg -> Money -> Money
update msg (Money amount currency) =
    case msg of
        SetAmount string ->
            String.toFloat string
                |> Maybe.withDefault 0
                |> (\newAmount -> Money newAmount currency)

        SetCurrency newCurrency ->
            Money amount newCurrency


view : String -> Money -> Html Msg
view labelText money =
    label [] (text labelText :: unlabeledView money)


unlabeledView : Money -> List (Html Msg)
unlabeledView (Money amount currency) =
    [ input
        [ type_ "number"
        , value (String.fromFloat amount)
        , onInput SetAmount
        ]
        []
    , Select.view
        { label = ""
        , valuesWithLabels = Money.currenciesWithLabels
        , defaultValue = currency
        , onOptionSelected = SetCurrency
        }
    ]
