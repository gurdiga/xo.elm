module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.BunurileUrmarite exposing (BunurileUrmarite, newValue, view)

import Html exposing (Html, fieldset, legend, p, text)
import MyDate
import Widgets.Table as Table
import Widgets.Fields exposing (unlabeledMoneyField, unlabeledLargeTextField)
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.BunurileUrmarite.BunUrmarit as BunUrmarit
    exposing
        ( BunUrmarit(BunUrmarit)
        )


type BunurileUrmarite
    = BunurileUrmarite (List BunUrmarit)


newValue : BunurileUrmarite
newValue =
    BunurileUrmarite []


view : BunurileUrmarite -> (BunurileUrmarite -> msg) -> Html msg
view bunurileUrmarite callback =
    fieldset []
        [ legend [] [ text "BunurileUrmarite" ]
        , tableView bunurileUrmarite callback
        ]


tableView : BunurileUrmarite -> (BunurileUrmarite -> msg) -> Html msg
tableView bunurileUrmarite callback =
    Table.view
        { data = data bunurileUrmarite
        , callback = callback << fromData
        , columns =
            [ ( "Denumire", (\r c -> MyDate.viewUnlabeled r.denumire (\v -> c { r | denumire = v })) )
            , ( "Valoare", (\r c -> unlabeledMoneyField r.valoare (\v -> c { r | valoare = v })) )
            , ( "Note", (\r c -> unlabeledLargeTextField r.note (\v -> c { r | note = v })) )
            ]
        , emptyView = emptyView
        , newValue = BunUrmarit.data BunUrmarit.newValue
        }


data : BunurileUrmarite -> List BunUrmarit.Data
data (BunurileUrmarite list) =
    List.map BunUrmarit.data list


fromData : List BunUrmarit.Data -> BunurileUrmarite
fromData =
    BunurileUrmarite << List.map BunUrmarit


emptyView : Html msg
emptyView =
    p [] [ text "Nu sunt bunuri înregistrate." ]
