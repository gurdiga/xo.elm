module Utils.DocumentScanatTea exposing (Model, Msg, initialModel, update, view)

import Html exposing (Html, code, div, input, label, text)
import Html.Attributes exposing (title, type_)
import Html.Events exposing (on)
import Json.Decode as Json
import Utils.File as File exposing (File)


type Msg
    = SetFile File


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        SetFile file ->
            Model { model | file = file }


type Model
    = Model { file : File }


type alias Input =
    { labelText : String
    , documentScanat : Model
    }


type alias Callback msg =
    Model -> msg


initialModel : Model
initialModel =
    Model
        { file = File.empty }


view : Input -> Html Msg
view { labelText, documentScanat } =
    let
        (Model d) =
            documentScanat
    in
    div []
        [ label []
            [ text labelText
            , input
                [ type_ "file"
                , onFileSelect SetFile
                , title d.file.path
                ]
                []
            ]
        ]


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
