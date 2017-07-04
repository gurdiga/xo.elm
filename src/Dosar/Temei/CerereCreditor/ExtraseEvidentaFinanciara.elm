module Dosar.Temei.CerereCreditor.ExtraseEvidentaFinanciara exposing (ExtraseEvidentaFinanciara, newValue, view)

import Html exposing (Html, fieldset, legend, text)
import Dosar.Temei.CerereCreditor.InregistrareEvidentaFinanciara as InregistrareEvidentaFinanciara exposing (InregistrareEvidentaFinanciara)


type ExtraseEvidentaFinanciara
    = ExtraseEvidentaFinanciara (List InregistrareEvidentaFinanciara)


newValue : ExtraseEvidentaFinanciara
newValue =
    ExtraseEvidentaFinanciara [ InregistrareEvidentaFinanciara.newValue ]


view : ExtraseEvidentaFinanciara -> (ExtraseEvidentaFinanciara -> msg) -> Html msg
view extraseEvidentaFinanciara callback =
    fieldset []
        [ legend [] [ text "ExtraseEvidentaFinanciara" ]
        , text (toString extraseEvidentaFinanciara)
        ]
