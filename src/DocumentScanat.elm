module DocumentScanat exposing (DocumentScanat, newValue, view)

import Html exposing (Html, label, input, text)
import Widgets.Fields exposing (fileField)


type alias DocumentScanat =
    { file : String }


newValue : DocumentScanat
newValue =
    { file = "DocumentScanat TODO" }


view : String -> DocumentScanat -> (DocumentScanat -> msg) -> Html msg
view labelText documentScanat callback =
    fileField labelText (\v -> callback { documentScanat | file = (Debug.log "file" v) })
