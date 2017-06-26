module Dosar.Temei.CerereCreditor exposing (CerereCreditor, newValue, view)

import Html exposing (Html, fieldset, legend, label, textarea, text)
import Dosar.Persoană as Persoană exposing (Persoană)
import Widgets.Fields exposing (largeTextField)


type alias CerereCreditor =
    { creditor : Persoană
    , text : String
    }


newValue : CerereCreditor
newValue =
    { creditor = Persoană.newValue
    , text = ""
    }


view : CerereCreditor -> (CerereCreditor -> msg) -> Html msg
view cerereCreditor callback =
    fieldset []
        [ legend [] [ text "CerereCreditor" ]
        , Persoană.view cerereCreditor.creditor (\v -> callback { cerereCreditor | creditor = v })
        , largeTextField "Text cerere:" cerereCreditor.text (\v -> callback { cerereCreditor | text = v })
        ]
