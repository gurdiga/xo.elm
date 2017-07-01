module DocumentScanat exposing (DocumentScanat, newValue, view)

import Html exposing (Html, label, input, text)
import File exposing (File)
import Widgets.Fields exposing (fileField)


type alias DocumentScanat =
    { file : File }


newValue : DocumentScanat
newValue =
    { file = File.newValue }


view : String -> DocumentScanat -> (DocumentScanat -> msg) -> Html msg
view labelText documentScanat callback =
    fileField labelText (\v -> callback { documentScanat | file = v })
