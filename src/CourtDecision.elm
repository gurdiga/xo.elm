module CourtDecision exposing (Type, Msg, newValue, fields)

import Html exposing (Html, div, fieldset, legend, text)
import Html.Attributes exposing (title)
import CourtDecision.Cause as Cause
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


changeCause : Type -> Cause.Type -> Type
changeCause decision newCause =
    { decision | cause = newCause }


fields : Type -> (Type -> msg) -> Html msg
fields decision msgConstructor =
    fieldset []
        [ legend [] [ text "CourtDecision" ]
        , Cause.field decision.cause <| msgConstructor << changeCause decision
        ]
