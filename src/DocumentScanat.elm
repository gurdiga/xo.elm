module DocumentScanat exposing (DocumentScanat, newValue, view, unlabeledView)

import Html exposing (Html, div, label, input, text)
import Html.Attributes exposing (type_)
import Html.Events exposing (on)
import Json.Decode as Json
import File exposing (File)


type alias DocumentScanat =
    { file : File }


type alias Input msg =
    { labelText : String
    , documentScanat : DocumentScanat
    , callback : DocumentScanat -> msg
    }


newValue : DocumentScanat
newValue =
    { file = File.newValue }


view : Input msg -> Html msg
view { labelText, documentScanat, callback } =
    div []
        [ fileField labelText (\v -> callback { documentScanat | file = v })
        ]


unlabeledView : DocumentScanat -> (DocumentScanat -> msg) -> Html msg
unlabeledView documentScanat callback =
    unlabeledFileField (\v -> callback { documentScanat | file = v })


fileField : String -> (File -> msg) -> Html msg
fileField labelText callback =
    label []
        [ text labelText
        , unlabeledFileField callback
        ]


unlabeledFileField : (File -> msg) -> Html msg
unlabeledFileField callback =
    input
        [ type_ "file"
        , onFileSelect callback
        ]
        []


onFileSelect : (File -> msg) -> Html.Attribute msg
onFileSelect callback =
    let
        eventDecoder : Json.Decoder msg
        eventDecoder =
            Json.map
                (\targetValue -> callback (File targetValue))
                (Json.at [ "target", "value" ] Json.string)
    in
        on "change" eventDecoder
