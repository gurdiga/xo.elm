module Dosar.Temei.CerereCreditor.InregistrareEvidentaFinanciara exposing (InregistrareEvidentaFinanciara(InregistrareEvidentaFinanciara), Data, newValue, data, view)

import Html exposing (Html, tr, td, text)
import Html.Attributes exposing (style)
import Money exposing (Money(Money), Currency(MDL))
import MyDate exposing (MyDate)
import Widgets.Fields exposing (unlabeledDateField, unlabeledMoneyField, unlabeledLargeTextField)


type InregistrareEvidentaFinanciara
    = InregistrareEvidentaFinanciara Data


type alias Data =
    { data : MyDate
    , suma : Money
    , note : String
    }


newValue : InregistrareEvidentaFinanciara
newValue =
    InregistrareEvidentaFinanciara
        { data = MyDate.newValue
        , suma = Money 0 MDL
        , note = ""
        }


data : InregistrareEvidentaFinanciara -> Data
data (InregistrareEvidentaFinanciara data) =
    data


view : InregistrareEvidentaFinanciara -> (InregistrareEvidentaFinanciara -> msg) -> Html msg
view (InregistrareEvidentaFinanciara i) callback =
    let
        tdStyle =
            style [ ( "border", "1px solid silver" ) ]
    in
        tr []
            [ td [ tdStyle ] <| unlabeledDateField i.data (\v -> callback (InregistrareEvidentaFinanciara { i | data = v }))
            , td [ tdStyle ] <| unlabeledMoneyField i.suma (\v -> callback (InregistrareEvidentaFinanciara { i | suma = v }))
            , td [ tdStyle ] <| unlabeledLargeTextField i.note (\v -> callback (InregistrareEvidentaFinanciara { i | note = v }))
            ]
