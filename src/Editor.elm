port module Editor exposing (view, sendToEditor, receiveFromEditor)

import Html exposing (Html, program, div, pre, button, text)
import Html.Events exposing (onClick)


view : String -> (String -> msg) -> Html msg
view s callback =
    div [] [ button [ onClick (callback s) ] [ text "Edit" ] ]


port sendToEditor : String -> Cmd msg


port receiveFromEditor : (String -> msg) -> Sub msg
