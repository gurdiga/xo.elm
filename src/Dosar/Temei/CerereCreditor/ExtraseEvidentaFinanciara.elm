module Dosar.Temei.CerereCreditor.ExtraseEvidentaFinanciara exposing (ExtraseEvidentaFinanciara, newValue, view)

import Html exposing (Html, fieldset, legend, div, p, table, thead, tr, th, button, text)
import Html.Attributes exposing (style, title)
import Html.Events exposing (onClick)
import Dosar.Temei.CerereCreditor.InregistrareEvidentaFinanciara as InregistrareEvidentaFinanciara exposing (InregistrareEvidentaFinanciara)


type ExtraseEvidentaFinanciara
    = ExtraseEvidentaFinanciara (List InregistrareEvidentaFinanciara)


newValue : ExtraseEvidentaFinanciara
newValue =
    ExtraseEvidentaFinanciara []


view : ExtraseEvidentaFinanciara -> (ExtraseEvidentaFinanciara -> msg) -> Html msg
view extraseEvidentaFinanciara callback =
    case extraseEvidentaFinanciara of
        ExtraseEvidentaFinanciara inregistrariEvidentaFinanciara ->
            fieldset []
                [ legend [] [ text "ExtraseEvidentaFinanciara" ]
                , if List.isEmpty inregistrariEvidentaFinanciara then
                    emptyView
                  else
                    list extraseEvidentaFinanciara callback
                , appendView extraseEvidentaFinanciara callback
                ]


emptyView : Html msg
emptyView =
    p [] [ text "Nu sunt înregistrări." ]


list : ExtraseEvidentaFinanciara -> (ExtraseEvidentaFinanciara -> msg) -> Html msg
list extraseEvidentaFinanciara callback =
    case extraseEvidentaFinanciara of
        ExtraseEvidentaFinanciara inregistrariEvidentaFinanciara ->
            table [ style [ ( "border", "1px solid silver" ), ( "border-collapse", "collapse" ) ] ]
                (thead
                    []
                    [ let
                        thStyle =
                            style [ ( "border", "1px solid silver" ) ]
                      in
                        tr []
                            [ th [ thStyle ] [ text "Data" ]
                            , th [ thStyle ] [ text "Suma" ]
                            , th [ thStyle ] [ text "Note" ]
                            ]
                    ]
                    :: let
                        mapper i v =
                            InregistrareEvidentaFinanciara.view v
                                (\newV ->
                                    callback (replace extraseEvidentaFinanciara i newV)
                                )
                       in
                        List.indexedMap mapper inregistrariEvidentaFinanciara
                )


appendView : ExtraseEvidentaFinanciara -> (ExtraseEvidentaFinanciara -> msg) -> Html msg
appendView extraseEvidentaFinanciara callback =
    button
        [ title "Adaugă înregistrare"
        , onClick
            (\_ ->
                callback (append extraseEvidentaFinanciara InregistrareEvidentaFinanciara.newValue)
            )
        ]
        [ text "+" ]


replace : ExtraseEvidentaFinanciara -> Int -> InregistrareEvidentaFinanciara -> ExtraseEvidentaFinanciara
replace (ExtraseEvidentaFinanciara inregistrariEvidentaFinanciara) index newValue =
    let
        mapper i v =
            if i == index then
                newValue
            else
                v
    in
        ExtraseEvidentaFinanciara (List.indexedMap mapper inregistrariEvidentaFinanciara)


append : ExtraseEvidentaFinanciara -> InregistrareEvidentaFinanciara -> ExtraseEvidentaFinanciara
append (ExtraseEvidentaFinanciara inregistrariEvidentaFinanciara) inregistrareEvidentaFinanciara =
    ExtraseEvidentaFinanciara (inregistrariEvidentaFinanciara ++ [ inregistrareEvidentaFinanciara ])
