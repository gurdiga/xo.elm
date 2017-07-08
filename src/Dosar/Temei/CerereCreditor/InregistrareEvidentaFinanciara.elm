module Dosar.Temei.CerereCreditor.InregistrareEvidentaFinanciara exposing (InregistrareEvidentaFinanciara, newValue, view)

import Html exposing (Html, tr, td, text)
import Html.Attributes exposing (style)
import Money exposing (Money(Money), Currency(MDL))
import MyDate exposing (MyDate)
import Widgets.Fields exposing (unlabeledDateField, unlabeledMoneyField, unlabeledTextField)


type alias InregistrareEvidentaFinanciara =
    { data : MyDate
    , suma : Money
    , note : String
    }


newValue : InregistrareEvidentaFinanciara
newValue =
    { data = MyDate.newValue
    , suma = Money 0 MDL
    , note = ""
    }


view : InregistrareEvidentaFinanciara -> (InregistrareEvidentaFinanciara -> msg) -> Html msg
view i callback =
    let
        tdStyle =
            style [ ( "border", "1px solid silver" ) ]

        dateField =
            unlabeledDateField i.data (\v -> callback { i | data = v })

        moneyField =
            unlabeledMoneyField i.suma (\v -> callback { i | suma = v })

        textField =
            unlabeledTextField i.note (\v -> callback { i | note = v })
    in
        tr []
            [ td [ tdStyle ] [ dateField.fieldElement, dateField.errorMessageElement ]
            , td [ tdStyle ] [ moneyField.amountFieldElement, moneyField.currencyFieldElement ]
            , td [ tdStyle ] [ textField ]
            ]
