module CourtDecision exposing (Value, Msg, newValue, fields)

import Html exposing (Html, div, fieldset, legend, text)
import Html.Attributes exposing (title)
import CourtDecisionCause as Cause
import Select


type Msg
    = Change Cause.Msg


type alias Value =
    { cause : Cause.Type
    }


newValue : Value
newValue =
    { cause = Cause.newValue
    }


fields : Value -> (Msg -> msg) -> Html msg
fields value msgConstructor =
    fieldset [ title <| toString value ]
        [ legend [] [ text "CourtDecision" ]
        , Cause.field value.cause (msgConstructor Change)
        ]
