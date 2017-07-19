port module Editor exposing (sendToEditor, receiveFromEditor)


port sendToEditor : String -> Cmd msg


port receiveFromEditor : (String -> msg) -> Sub msg
