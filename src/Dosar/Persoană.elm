module Dosar.Persoană exposing (Type, newValue, view)

import Html exposing (Html, fieldset, legend, text)


type Type
    = Persoană


newValue : Type
newValue =
    Persoană


view : Type -> (Type -> msg) -> Html msg
view person callback =
    fieldset []
        [ legend [] [ text "Persoană" ]
        , text ("TODO" ++ (toString person))
        ]
