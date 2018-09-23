module Widgets.DocumentScanat3 exposing (Model, initialModel, toString, view)

import Html exposing (Attribute, Html, div, input, label, map, text)
import Html.Attributes exposing (type_)
import Html.Events exposing (on)
import Json.Decode as Json
import Utils.File as File exposing (File)


type alias Model =
    File


initialModel : Model
initialModel =
    File.empty


toString : Model -> String
toString model =
    File.toString model


view : String -> (Model -> msg) -> Html msg
view labelText toMsg =
    label []
        [ text labelText
        , input [ type_ "file", onFileSelect toMsg ] []
        ]


onFileSelect : (Model -> msg) -> Attribute msg
onFileSelect toMsg =
    let
        eventDecoder : Json.Decoder msg
        eventDecoder =
            Json.map
                (\targetValue -> toMsg (File targetValue))
                (Json.at [ "target", "value" ] Json.string)
    in
    on "change" eventDecoder
