module Dosar.DemersInstanta exposing (Type, Msg, newValue, view)

import Html exposing (Html, div, fieldset, legend, text)
import Dosar.DemersInstanta.Cause as Cause


type Msg
    = CauseChange Cause.Type


type alias Type =
    { cause : Cause.Type
    }


newValue : Type
newValue =
    { cause = Cause.newValue
    }


view : Type -> (Type -> msg) -> Html msg
view decision callback =
    fieldset []
        [ legend [] [ text "Demers al instantei de judecata:" ]
        , Cause.field decision.cause (\v -> callback { decision | cause = v })
        ]
