module Widgets.DocumentScanat3 exposing (view)

import Html exposing (Attribute, Html, div, input, label, map, text)
import Html.Attributes exposing (type_)
import Html.Events exposing (on)
import Json.Decode as Json
import Utils.File as File exposing (File)


view : String -> (File -> msg) -> Html msg
view labelText toMsg =
    label []
        [ text labelText
        , input [ type_ "file", onFileSelect toMsg ] []
        ]


onFileSelect : (File -> msg) -> Attribute msg
onFileSelect toMsg =
    let
        eventDecoder : Json.Decoder msg
        eventDecoder =
            Json.map
                (\targetValue -> toMsg (File targetValue))
                (Json.at [ "target", "value" ] Json.string)
    in
    on "change" eventDecoder
