module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActeEfectuateAnterior exposing (ActeEfectuateAnterior, newValue, view)

import Html exposing (Html, fieldset, legend, table, thead, tr, th, p, button, text)
import Html.Attributes exposing (style, title)
import Html.Events exposing (onClick)
import Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActEfectuatAnterior as ActEfectuatAnterior exposing (ActEfectuatAnterior(ActEfectuatAnterior))
import Utils.List as ListUtils
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
        , if isEmpty acteEfectuatAnterior then
            emptyView
          else
            tableView acteEfectuatAnterior callback
        , appendView acteEfectuatAnterior callback
        ]


isEmpty : ActeEfectuateAnterior -> Bool
isEmpty (ActeEfectuateAnterior list) =
    List.isEmpty list


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
        }


data : ActeEfectuateAnterior -> List ActEfectuatAnterior.Data
data (ActeEfectuateAnterior list) =
    List.map ActEfectuatAnterior.data list


fromData : List ActEfectuatAnterior.Data -> ActeEfectuateAnterior
fromData =
    ActeEfectuateAnterior << List.map ActEfectuatAnterior


listView : List ActEfectuatAnterior -> (List ActEfectuatAnterior -> msg) -> Html msg
listView list callback =
    table [ style [ ( "border", "1px solid silver" ), ( "border-collapse", "collapse" ) ] ]
        (thead
            []
            [ let
                thStyle =
                    style [ ( "border", "1px solid silver" ) ]
              in
                tr []
                    [ th [ thStyle ] [ text "Copia scanată" ]
                    , th [ thStyle ] [ text "Note" ]
                    ]
            ]
            :: (let
                    mapper i v =
                        ActEfectuatAnterior.view v (\newV -> callback (ListUtils.replace list i newV))
                in
                    List.indexedMap mapper list
               )
        )


emptyView : Html msg
emptyView =
    p [] [ text "Nu sunt acte efectuate anterior." ]


appendView : ActeEfectuateAnterior -> Callback msg -> Html msg
appendView (ActeEfectuateAnterior list) callback =
    button
        [ title "Adaugă înregistrare"
        , onClick (callback <| ActeEfectuateAnterior <| List.append list [ ActEfectuatAnterior.newValue ])
        ]
        [ text "+" ]
