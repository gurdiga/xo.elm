module CourtDecision exposing (Value, Msg, newValue, fields)

import Html exposing (Html, div, fieldset, legend, text)
import Html.Attributes exposing (title)
import CourtDecision.Cause as Cause
import Select


type Msg
    = CauseChange Cause.Type


type alias Value =
    { cause : Cause.Type
    }


newValue : Value
newValue =
    { cause = Cause.newValue
    }


changeCause : Value -> Cause.Type -> Value
changeCause decision newCause =
    { decision | cause = newCause }


fields : Value -> (Value -> msg) -> Html msg
fields decision msgConstructor =
    fieldset []
        [ legend [] [ text "CourtDecision" ]
        , Cause.field decision.cause <| msgConstructor << changeCause decision
        ]
