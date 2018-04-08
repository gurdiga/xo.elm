module Dosar.Temei.PreluareDocumentExecutoriuStramutat.DocumentScanat2 exposing (Model, empty, view)

import Html.Styled exposing (Attribute, Html, div, input, label, text, map)
import Html.Styled.Attributes exposing (type_)
import Html.Styled.Events exposing (on)
import Json.Decode as Json
import Utils.File as File exposing (File)


type alias Model =
    { file : File
    }


type alias Input msg =
    { labelText : String
    , initialModel : Model
    , callback : Callback msg
    }


type alias Callback msg =
    Model -> msg


empty : Model
empty =
    { file = File.empty
    }


view : Input msg -> Html msg
view ({ labelText, initialModel, callback } as data) =
    div []
        [ fileField labelText (\v -> callback { initialModel | file = v })
        ]


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


onFileSelect : (File -> msg) -> Attribute msg
onFileSelect callback =
    let
        eventDecoder : Json.Decoder msg
        eventDecoder =
            Json.map
                (\targetValue -> callback (File targetValue))
                (Json.at [ "target", "value" ] Json.string)
    in
        on "change" eventDecoder
