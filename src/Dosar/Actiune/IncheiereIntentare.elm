module Dosar.Actiune.IncheiereIntentare exposing (IncheiereIntentare, newValue, view)

import Html exposing (Html, fieldset, legend, div, text)


type IncheiereIntentare
    = IncheiereIntentare


newValue : IncheiereIntentare
newValue =
    IncheiereIntentare


view : Html msg
view =
    fieldset []
        [ legend [] [ text "IncheiereIntentare", div [] [ text "TODO" ] ]
        ]
