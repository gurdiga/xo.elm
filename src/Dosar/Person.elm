module Dosar.Person exposing (Type, newValue, view)

import Html exposing (Html, fieldset, legend, text)


type Type
    = Person


newValue : Type
newValue =
    Person


view : Type -> (Type -> msg) -> Html msg
view person callback =
    fieldset []
        [ legend [] [ text "Persoană" ]
        , text ("TODO" ++ (toString person))
        ]
