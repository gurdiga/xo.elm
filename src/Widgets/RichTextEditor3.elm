module Widgets.RichTextEditor3 exposing (view)

import Html exposing (Html, label, text, textarea)
import Html.Attributes exposing (value)
import Html.Events exposing (onInput)


view : String -> String -> (String -> msg) -> Html msg
view labelText fieldValue toMsg =
    label []
        [ text labelText
        , textarea [ onInput toMsg, value fieldValue ] []
        ]
