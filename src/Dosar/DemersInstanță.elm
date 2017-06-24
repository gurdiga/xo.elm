module Dosar.DemersInstanță exposing (Type, Msg, newValue, view)

import Html exposing (Html, div, fieldset, legend, text)
import Html.Attributes exposing (title)
import Dosar.DemersInstanță.Cause as Cause
import Select


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
        [ legend [] [ text "Demers al instanței de judecată:" ]
        , Cause.field decision.cause (\v -> callback { decision | cause = v })
        ]
