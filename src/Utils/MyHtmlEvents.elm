module Utils.MyHtmlEvents exposing (onClick)

import Json.Decode
import Html
import Html.Events


onClick : (String -> msg) -> Html.Attribute msg
onClick callback =
    Html.Events.on "click" (Json.Decode.map callback Html.Events.targetValue)
