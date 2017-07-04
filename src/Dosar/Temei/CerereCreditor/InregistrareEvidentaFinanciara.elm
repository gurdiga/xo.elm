module Dosar.Temei.CerereCreditor.InregistrareEvidentaFinanciara exposing (InregistrareEvidentaFinanciara, newValue, view)

import Html exposing (Html, text)
import Money exposing (Money(Money), Currency(MDL))
import MyDate exposing (MyDate)


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
view inregistrareEvidentaFinanciara callback =
    text ("InregistrareEvidentaFinanciara" ++ (toString inregistrareEvidentaFinanciara))
