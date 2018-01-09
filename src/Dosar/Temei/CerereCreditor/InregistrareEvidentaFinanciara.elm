module Dosar.Temei.CerereCreditor.InregistrareEvidentaFinanciara exposing (Data, InregistrareEvidentaFinanciara(InregistrareEvidentaFinanciara), data, empty, view)

import Html exposing (Html, td, text, tr)
import Html.Attributes exposing (style)
import Utils.Money as Money exposing (Currency(MDL), Money(Money))
import Utils.MyDate as MyDate exposing (MyDate)
import Widgets.Fields exposing (unlabeledLargeTextField, unlabeledMoneyField)


type InregistrareEvidentaFinanciara
    = InregistrareEvidentaFinanciara Data


type alias Data =
    { data : MyDate
    , suma : Money
    , note : String
    }


empty : InregistrareEvidentaFinanciara
empty =
    InregistrareEvidentaFinanciara
        { data = MyDate.empty
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
        [ td [ tdStyle ] <| MyDate.viewUnlabeled i.data (\v -> callback (InregistrareEvidentaFinanciara { i | data = v }))
        , td [ tdStyle ] <| unlabeledMoneyField i.suma (\v -> callback (InregistrareEvidentaFinanciara { i | suma = v }))
        , td [ tdStyle ] <| unlabeledLargeTextField i.note (\v -> callback (InregistrareEvidentaFinanciara { i | note = v }))
        ]
