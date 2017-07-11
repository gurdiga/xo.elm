module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActeEfectuateAnterior exposing (ActeEfectuateAnterior, newValue, view)

import Html exposing (Html, fieldset, legend, p, text)
import Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActEfectuatAnterior as ActEfectuatAnterior exposing (ActEfectuatAnterior(ActEfectuatAnterior))
import Widgets.Table as Table
import Widgets.Fields exposing (unlabeledLargeTextField)
import DocumentScanat


type ActeEfectuateAnterior
    = ActeEfectuateAnterior (List ActEfectuatAnterior)


type alias Callback msg =
    ActeEfectuateAnterior -> msg


newValue : ActeEfectuateAnterior
newValue =
    ActeEfectuateAnterior [ ActEfectuatAnterior.newValue ]


view : ActeEfectuateAnterior -> Callback msg -> Html msg
view acteEfectuatAnterior callback =
    fieldset []
        [ legend [] [ text "ActeEfectuateAnterior" ]
        , tableView acteEfectuatAnterior callback
        ]


tableView : ActeEfectuateAnterior -> Callback msg -> Html msg
tableView acteEfectuatAnterior callback =
    Table.view
        { data = data acteEfectuatAnterior
        , callback = callback << fromData
        , columns =
            [ ( "Copia scanată"
              , (\r c -> DocumentScanat.unlabeledView r.copie (\v -> c { r | copie = v }))
              )
            , ( "Note"
              , (\r c -> unlabeledLargeTextField r.note (\v -> c { r | note = v }))
              )
            ]
        , emptyView = emptyView
        , newValue = ActEfectuatAnterior.data ActEfectuatAnterior.newValue
        }


data : ActeEfectuateAnterior -> List ActEfectuatAnterior.Data
data (ActeEfectuateAnterior list) =
    List.map ActEfectuatAnterior.data list


fromData : List ActEfectuatAnterior.Data -> ActeEfectuateAnterior
fromData =
    ActeEfectuateAnterior << List.map ActEfectuatAnterior


emptyView : Html msg
emptyView =
    p [] [ text "Nu sunt acte efectuate anterior." ]
