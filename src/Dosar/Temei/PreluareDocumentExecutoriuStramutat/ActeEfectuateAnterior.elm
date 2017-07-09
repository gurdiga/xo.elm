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


newValue : ActeEfectuateAnterior
newValue =
    ActeEfectuateAnterior [ ActEfectuatAnterior.newValue ]


view : ActeEfectuateAnterior -> (ActeEfectuateAnterior -> msg) -> Html msg
view acteEfectuatAnterior callback =
    let
        (ActeEfectuateAnterior list) =
            acteEfectuatAnterior
    in
        fieldset []
            [ legend [] [ text "ActeEfectuateAnterior" ]
            , if List.isEmpty list then
                emptyView
              else
                listView list (\v -> callback (ActeEfectuateAnterior v))
            , appendView list (\v -> callback (ActeEfectuateAnterior v))
            , Table.view
                (List.map ActEfectuatAnterior.data list)
                (\newRecords -> callback <| ActeEfectuateAnterior <| List.map ActEfectuatAnterior newRecords)
                [ ( "Copia scanată"
                  , (\record c -> DocumentScanat.unlabeledView record.copie (\v -> c { record | copie = v }))
                  )
                , ( "Note"
                  , (\record c -> unlabeledLargeTextField record.note (\v -> c { record | note = v }))
                  )
                ]
            ]


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


appendView : List ActEfectuatAnterior -> (List ActEfectuatAnterior -> msg) -> Html msg
appendView list callback =
    button
        [ title "Adaugă înregistrare"
        , onClick (callback (List.append list [ ActEfectuatAnterior.newValue ]))
        ]
        [ text "+" ]
