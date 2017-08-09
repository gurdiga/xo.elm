module Dosar.Temei.CerereCreditor.ExtraseEvidentaFinanciara exposing (ExtraseEvidentaFinanciara, newValue, view)

import Html exposing (Html, fieldset, legend, p, text)
import Dosar.Temei.CerereCreditor.InregistrareEvidentaFinanciara as InregistrareEvidentaFinanciara exposing (InregistrareEvidentaFinanciara(InregistrareEvidentaFinanciara))
import Utils.List as ListUtils
import Widgets.Table as Table
import Widgets.Fields exposing (unlabeledMoneyField, unlabeledLargeTextField)
import MyDate


type ExtraseEvidentaFinanciara
    = ExtraseEvidentaFinanciara (List InregistrareEvidentaFinanciara)


newValue : ExtraseEvidentaFinanciara
newValue =
    ExtraseEvidentaFinanciara []


view : ExtraseEvidentaFinanciara -> (ExtraseEvidentaFinanciara -> msg) -> Html msg
view extraseEvidentaFinanciara callback =
    let
        (ExtraseEvidentaFinanciara inregistrariEvidentaFinanciara) =
            extraseEvidentaFinanciara
    in
        fieldset []
            [ legend [] [ text "ExtraseEvidentaFinanciara" ]
            , tableView extraseEvidentaFinanciara callback
            ]


tableView : ExtraseEvidentaFinanciara -> (ExtraseEvidentaFinanciara -> msg) -> Html msg
tableView extraseEvidentaFinanciara callback =
    Table.view
        { data = data extraseEvidentaFinanciara
        , callback = callback << fromData
        , columns =
            [ ( "Data", (\r c -> MyDate.viewUnlabeled r.data (\v -> c { r | data = v })) )
            , ( "Suma", (\r c -> unlabeledMoneyField r.suma (\v -> c { r | suma = v })) )
            , ( "Note", (\r c -> unlabeledLargeTextField r.note (\v -> c { r | note = v })) )
            ]
        , emptyView = emptyView
        , newValue = InregistrareEvidentaFinanciara.data InregistrareEvidentaFinanciara.newValue
        }


data : ExtraseEvidentaFinanciara -> List InregistrareEvidentaFinanciara.Data
data (ExtraseEvidentaFinanciara list) =
    List.map InregistrareEvidentaFinanciara.data list


fromData : List InregistrareEvidentaFinanciara.Data -> ExtraseEvidentaFinanciara
fromData =
    ExtraseEvidentaFinanciara << List.map InregistrareEvidentaFinanciara


emptyView : Html msg
emptyView =
    p [] [ text "Nu sunt înregistrări." ]


replace : ExtraseEvidentaFinanciara -> Int -> InregistrareEvidentaFinanciara -> ExtraseEvidentaFinanciara
replace (ExtraseEvidentaFinanciara inregistrariEvidentaFinanciara) index newValue =
    ExtraseEvidentaFinanciara (ListUtils.replace inregistrariEvidentaFinanciara index newValue)


append : ExtraseEvidentaFinanciara -> InregistrareEvidentaFinanciara -> ExtraseEvidentaFinanciara
append (ExtraseEvidentaFinanciara inregistrariEvidentaFinanciara) inregistrareEvidentaFinanciara =
    ExtraseEvidentaFinanciara (inregistrariEvidentaFinanciara ++ [ inregistrareEvidentaFinanciara ])
