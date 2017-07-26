module Dosar.Actiune.IncheiereRefuz exposing (IncheiereRefuz, newValue, view)

import Html exposing (Html, fieldset, legend, div, text)


type IncheiereRefuz
    = IncheiereRefuz


newValue : IncheiereRefuz
newValue =
    IncheiereRefuz


view : Html msg
view =
    fieldset []
        [ legend [] [ text "IncheiereRefuz" ]
        , div [] [ text "TODO" ]
        ]
