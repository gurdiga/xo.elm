module Widgets.MoneyField exposing (Msg, initialModel, update, view)

import Html.Styled exposing (Html, fromUnstyled, input, label, text)
import Html.Styled.Attributes exposing (css, type_, value)
import Html.Styled.Events exposing (onInput)
import Utils.Money as Money exposing (Currency(..), Money(..))
import Widgets.Select as Select


-- import Widgets.TextField.Css as Css


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
                |> Result.withDefault 0
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
        , value (toString amount)
        , onInput SetAmount
        ]
        []
    , Select.unlabeledView Money.currenciesWithLabels currency SetCurrency |> fromUnstyled
    ]
