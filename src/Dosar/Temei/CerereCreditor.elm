module Dosar.Temei.CerereCreditor exposing (CerereCreditor, newValue, view)

import Html exposing (Html, fieldset, legend, label, textarea, text)
import Html.Events exposing (onInput)
import Dosar.Persoană as Persoană


type alias CerereCreditor =
    { creditor : Persoană.Type
    , text : String
    }


newValue : CerereCreditor
newValue =
    { creditor = Persoană.newValue
    , text = ""
    }


view : CerereCreditor -> (CerereCreditor -> msg) -> Html msg
view cerere callback =
    fieldset []
        [ legend [] [ text "CerereCreditor" ]
        , Persoană.view cerere.creditor (\v -> callback { cerere | creditor = v })
        , label []
            [ text "Text cerere:"
            , textarea [ onInput (\v -> callback { cerere | text = v }) ] []
            ]
        ]
