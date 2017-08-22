module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.BunuriUrmarite exposing (BunuriUrmarite, empty, view)

import Html exposing (Html, fieldset, legend, p, text)
import Widgets.Table as Table
import Widgets.Fields exposing (unlabeledTextField, unlabeledMoneyField, unlabeledLargeTextField)
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.BunuriUrmarite.BunUrmarit as BunUrmarit
    exposing
        ( BunUrmarit(BunUrmarit)
        )


type BunuriUrmarite
    = BunuriUrmarite (List BunUrmarit)


empty : BunuriUrmarite
empty =
    BunuriUrmarite []


view : BunuriUrmarite -> (BunuriUrmarite -> msg) -> Html msg
view bunurileUrmarite callback =
    fieldset []
        [ legend [] [ text "BunuriUrmarite" ]
        , tableView bunurileUrmarite callback
        ]


tableView : BunuriUrmarite -> (BunuriUrmarite -> msg) -> Html msg
tableView bunurileUrmarite callback =
    Table.view
        { recordList = data bunurileUrmarite
        , callback = callback << fromData
        , columns =
            [ ( "Denumire", (\r c -> unlabeledTextField r.denumire (\v -> c { r | denumire = v })) )
            , ( "Valoare", (\r c -> unlabeledMoneyField r.valoare (\v -> c { r | valoare = v })) )
            , ( "Note", (\r c -> unlabeledLargeTextField r.note (\v -> c { r | note = v })) )
            ]
        , emptyView = text ""
        , empty = BunUrmarit.data BunUrmarit.empty
        }


data : BunuriUrmarite -> List BunUrmarit.Data
data (BunuriUrmarite list) =
    List.map BunUrmarit.data list


fromData : List BunUrmarit.Data -> BunuriUrmarite
fromData =
    BunuriUrmarite << List.map BunUrmarit
