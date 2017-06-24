module Dosar.Persoană.PersoanăJuridică exposing (PersoanăJuridică, newValue, view)

import Html exposing (Html, fieldset, legend, text)


type alias PersoanăJuridică =
    {}


newValue : PersoanăJuridică
newValue =
    {}


view : PersoanăJuridică -> (PersoanăJuridică -> msg) -> Html msg
view persoană callback =
    fieldset [] [ legend [] [ text "PersoanăJuridică" ] ]
