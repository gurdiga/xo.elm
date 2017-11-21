module Utils.MyHtmlEvents
    exposing
        ( onClick
        , onFocus
        )

import Json.Decode
import Html
import Html.Events


onClick : (String -> msg) -> Html.Attribute msg
onClick callback =
    Html.Events.on "click" (Json.Decode.map callback Html.Events.targetValue)


onFocus : (String -> msg) -> Html.Attribute msg
onFocus callback =
    Html.Events.on "focus" (Json.Decode.map callback Html.Events.targetValue)
