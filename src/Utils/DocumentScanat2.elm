module Utils.DocumentScanat2 exposing (Model, Msg, initialModel, update, view)

import Html.Styled exposing (Html, code, div, input, label, text)
import Html.Styled.Attributes exposing (title, type_)
import Html.Styled.Events exposing (on)
import Json.Decode as Json
import Utils.File as File exposing (File)


type alias Model =
    { file : File }


initialModel : Model
initialModel =
    { file = File.empty }


view : String -> Model -> Html Msg
view labelText model =
    div []
        [ label []
            [ text labelText
            , input
                [ type_ "file"
                , onFileSelect SetFile
                , title (toString model)
                ]
                []
            ]
        ]


onFileSelect : (File -> Msg) -> Html.Styled.Attribute Msg
onFileSelect callback =
    on "change" eventDecoder


eventDecoder : Json.Decoder Msg
eventDecoder =
    Json.map
        (\targetValue -> SetFile (File targetValue))
        (Json.at [ "target", "value" ] Json.string)


type Msg
    = SetFile File


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetFile v ->
            { model | file = v }