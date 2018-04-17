module Dosar.Temei.PreluareDocumentExecutoriuStramutat.DocumentScanat2 exposing (Model, Msg, initialModel, setCopie, update, view)

import Html.Styled exposing (Attribute, Html, div, input, label, map, text)
import Html.Styled.Attributes exposing (type_)
import Html.Styled.Events exposing (on)
import Json.Decode as Json
import Utils.File as File exposing (File)


type Msg
    = SetValue File


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetValue newFile ->
            { model | file = newFile }


setCopie : Model -> String -> Model
setCopie model newPath =
    { model | file = File.setPath model.file newPath }


type alias Model =
    { file : File
    }


type alias Input =
    { labelText : String
    , initialModel : Model
    }


initialModel : Model
initialModel =
    { file = File.empty
    }


view : String -> Model -> Html Msg
view labelText initialModel =
    label []
        [ text labelText
        , input [ type_ "file", onFileSelect SetValue ] []
        ]


onFileSelect : (File -> Msg) -> Attribute Msg
onFileSelect callback =
    let
        eventDecoder : Json.Decoder Msg
        eventDecoder =
            Json.map
                (\targetValue -> callback (File targetValue))
                (Json.at [ "target", "value" ] Json.string)
    in
    on "change" eventDecoder
