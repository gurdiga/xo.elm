module DocumentScanat exposing (DocumentScanat, newValue, view)

import Html exposing (Html, label, input, text)
import Html.Attributes exposing (type_)
import Html.Events exposing (on, onInput)
import Json.Decode as Json


type alias DocumentScanat =
    { file : String }


newValue : DocumentScanat
newValue =
    { file = "DocumentScanat TODO" }


view : String -> DocumentScanat -> (DocumentScanat -> msg) -> Html msg
view labelText documentScanat callback =
    label []
        [ text labelText
        , input
            [ type_ "file"
            , onFile (\v -> callback { documentScanat | file = v })
            ]
            []
        ]


onFile : (String -> msg) -> Html.Attribute msg
onFile callback =
    on "change" (Json.map callback Html.Events.targetValue)
