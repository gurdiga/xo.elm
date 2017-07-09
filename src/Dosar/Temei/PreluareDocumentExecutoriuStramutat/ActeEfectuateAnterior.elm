module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActeEfectuateAnterior exposing (ActeEfectuateAnterior, newValue, view)

import Html exposing (Html, fieldset, legend, table, thead, tr, th, p, button, text)
import Html.Attributes exposing (style, title)
import Html.Events exposing (onClick)
import Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActEfectuatAnterior as ActEfectuatAnterior exposing (ActEfectuatAnterior)


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
                        ActEfectuatAnterior.view v (\newV -> callback (replace list i newV))
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


replace : List ActEfectuatAnterior -> Int -> ActEfectuatAnterior -> List ActEfectuatAnterior
replace list index newValue =
    let
        mapper i v =
            if i == index then
                newValue
            else
                v
    in
        List.indexedMap mapper list
