module Dosar.Temei.CerereCreditor.ExtraseEvidentaFinanciara exposing (ExtraseEvidentaFinanciara, newValue, view)

import Html exposing (Html, fieldset, legend, div, table, thead, tr, th, button, text)
import Html.Attributes exposing (style)
import Dosar.Temei.CerereCreditor.InregistrareEvidentaFinanciara as InregistrareEvidentaFinanciara exposing (InregistrareEvidentaFinanciara)


type ExtraseEvidentaFinanciara
    = ExtraseEvidentaFinanciara (List InregistrareEvidentaFinanciara)


newValue : ExtraseEvidentaFinanciara
newValue =
    ExtraseEvidentaFinanciara []


view : ExtraseEvidentaFinanciara -> (ExtraseEvidentaFinanciara -> msg) -> Html msg
view (ExtraseEvidentaFinanciara inregistrariEvidentaFinanciara) callback =
    fieldset []
        [ legend [] [ text "ExtraseEvidentaFinanciara" ]
        , if List.length inregistrariEvidentaFinanciara == 0 then
            div []
                [ text "Nu sunt înregistrări."
                , button [] [ text "Adaugă" ]
                ]
          else
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
                    :: List.indexedMap
                        (\i v ->
                            InregistrareEvidentaFinanciara.view v
                                (\newV ->
                                    let
                                        replace index newValue =
                                            ExtraseEvidentaFinanciara
                                                (List.indexedMap
                                                    (\i v ->
                                                        if i == index then
                                                            newValue
                                                        else
                                                            v
                                                    )
                                                    inregistrariEvidentaFinanciara
                                                )
                                    in
                                        callback (replace i newV)
                                )
                        )
                        inregistrariEvidentaFinanciara
                )
        ]
