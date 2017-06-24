module Dosar.Persoană.PersoanăFizică exposing (PersoanăFizică, newValue, view)

import Html exposing (Html, fieldset, legend, label, input, text)
import Html.Events exposing (onInput)


type alias PersoanăFizică =
    { nume : String
    , prenume : String
    }


newValue : PersoanăFizică
newValue =
    { nume = ""
    , prenume = ""
    }


view : PersoanăFizică -> (PersoanăFizică -> msg) -> Html msg
view persoană callback =
    fieldset []
        [ legend [] [ text "PersoanăFizică" ]
        , label []
            [ text "Nume:"
            , input [ onInput (\v -> callback { persoană | nume = v }) ] []
            ]
        , label []
            [ text "Prenume:"
            , input [ onInput (\v -> callback { persoană | prenume = v }) ] []
            ]
        ]
