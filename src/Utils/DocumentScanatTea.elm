module Utils.DocumentScanatTea exposing (Model, Msg, initialModel, update, view)

import Html.Styled exposing (Html, div, input, label, text)
import Html.Styled.Attributes exposing (type_)
import Html.Styled.Events exposing (on)
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
    div []
        [ label []
            [ text labelText
            , input
                [ type_ "file"
                , onFileSelect SetFile
                ]
                []
            ]
        ]


onFileSelect : (File -> msg) -> Html.Styled.Attribute msg
onFileSelect callback =
    let
        eventDecoder : Json.Decoder msg
        eventDecoder =
            Json.map
                (\targetValue -> callback (File targetValue))
                (Json.at [ "target", "value" ] Json.string)
    in
    on "change" eventDecoder
