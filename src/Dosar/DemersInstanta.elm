module Dosar.DemersInstanta exposing (Type, newValue, view)

import Html exposing (Html, fieldset, legend, text)
import Dosar.DemersInstanta.Pricina as Pricina


type alias Type =
    { cause : Pricina.Type
    }


newValue : Type
newValue =
    { cause = Pricina.newValue
    }


view : Type -> (Type -> msg) -> Html msg
view decision callback =
    fieldset []
        [ legend [] [ text "Demers al instantei de judecata:" ]
        , Pricina.field decision.cause (\v -> callback { decision | cause = v })
        ]
