module Utils.DocumentScanat exposing (DocumentScanat, empty, view, unlabeledView)

import Html exposing (Html, div, label, input, text)
import Html.Attributes exposing (type_)
import Html.Events exposing (on)
import Json.Decode as Json
import Utils.File as File exposing (File)


type DocumentScanat
    = DocumentScanat Data


type alias Data =
    { file : File }


type alias Input msg =
    { labelText : String
    , documentScanat : DocumentScanat
    , callback : Callback msg
    }


type alias Callback msg =
    DocumentScanat -> msg


empty : DocumentScanat
empty =
    DocumentScanat
        { file = File.empty }


view : Input msg -> Html msg
view { labelText, documentScanat, callback } =
    let
        (DocumentScanat data) =
            documentScanat
    in
        div []
            [ fileField labelText (\v -> callback (DocumentScanat { data | file = v }))
            ]


unlabeledView : DocumentScanat -> Callback msg -> Html msg
unlabeledView (DocumentScanat data) callback =
    unlabeledFileField (\v -> callback (DocumentScanat { data | file = v }))


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
