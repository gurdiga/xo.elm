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


fields : Value -> (Value -> msg) -> Html msg
fields value msgConstructor =
    fieldset [ title <| toString value ]
        [ legend [] [ text "CourtDecision" ]
        , Cause.field value.cause (\v -> msgConstructor (Value v))
        ]
