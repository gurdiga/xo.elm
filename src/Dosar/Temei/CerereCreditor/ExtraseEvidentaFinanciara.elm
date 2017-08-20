module Dosar.Temei.CerereCreditor.ExtraseEvidentaFinanciara exposing (ExtraseEvidentaFinanciara, empty, view)

import Html exposing (Html, fieldset, legend, p, text)
import Dosar.Temei.CerereCreditor.InregistrareEvidentaFinanciara as InregistrareEvidentaFinanciara exposing (InregistrareEvidentaFinanciara(InregistrareEvidentaFinanciara))
import Widgets.Table as Table
import Widgets.Fields exposing (unlabeledMoneyField, unlabeledLargeTextField)
import MyDate


type ExtraseEvidentaFinanciara
    = ExtraseEvidentaFinanciara (List InregistrareEvidentaFinanciara)


empty : ExtraseEvidentaFinanciara
empty =
    ExtraseEvidentaFinanciara []


view : ExtraseEvidentaFinanciara -> (ExtraseEvidentaFinanciara -> msg) -> Html msg
view extraseEvidentaFinanciara callback =
    fieldset []
        [ legend [] [ text "ExtraseEvidentaFinanciara" ]
        , Table.view
            { data = data extraseEvidentaFinanciara
            , callback = callback << fromData
            , columns =
                [ ( "Data", (\r c -> MyDate.viewUnlabeled r.data (\v -> c { r | data = v })) )
                , ( "Suma", (\r c -> unlabeledMoneyField r.suma (\v -> c { r | suma = v })) )
                , ( "Note", (\r c -> unlabeledLargeTextField r.note (\v -> c { r | note = v })) )
                ]
            , emptyView = emptyView
            , empty = InregistrareEvidentaFinanciara.data InregistrareEvidentaFinanciara.empty
            }
        ]


data : ExtraseEvidentaFinanciara -> List InregistrareEvidentaFinanciara.Data
data (ExtraseEvidentaFinanciara list) =
    List.map InregistrareEvidentaFinanciara.data list


fromData : List InregistrareEvidentaFinanciara.Data -> ExtraseEvidentaFinanciara
fromData =
    ExtraseEvidentaFinanciara << List.map InregistrareEvidentaFinanciara


emptyView : Html msg
emptyView =
    p [] [ text "Nu sunt înregistrări." ]
