module Dosar.Temei.CerereCreditor.ExtraseEvidentaFinanciara exposing (ExtraseEvidentaFinanciara, newValue, view)

import Html exposing (Html, fieldset, legend, ul, li, text)
import Dosar.Temei.CerereCreditor.InregistrareEvidentaFinanciara as InregistrareEvidentaFinanciara exposing (InregistrareEvidentaFinanciara)


type ExtraseEvidentaFinanciara
    = ExtraseEvidentaFinanciara (List InregistrareEvidentaFinanciara)


newValue : ExtraseEvidentaFinanciara
newValue =
    ExtraseEvidentaFinanciara [ InregistrareEvidentaFinanciara.newValue ]


view : ExtraseEvidentaFinanciara -> (ExtraseEvidentaFinanciara -> msg) -> Html msg
view (ExtraseEvidentaFinanciara inregistrariEvidentaFinanciara) callback =
    fieldset []
        [ legend [] [ text "ExtraseEvidentaFinanciara" ]
        , ul []
            (List.indexedMap
                (\i v ->
                    li []
                        [ InregistrareEvidentaFinanciara.view v
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
                        ]
                )
                inregistrariEvidentaFinanciara
            )
        ]
