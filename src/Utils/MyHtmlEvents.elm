module Utils.MyHtmlEvents
    exposing
        ( onClick
        , onFocus
        , onMouseOver
        , onMouseOut
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


onMouseOver : (String -> msg) -> Html.Attribute msg
onMouseOver callback =
    Html.Events.on "mouseover" (Json.Decode.map callback Html.Events.targetValue)


onMouseOut : (String -> msg) -> Html.Attribute msg
onMouseOut callback =
    Html.Events.on "mouseout" (Json.Decode.map callback Html.Events.targetValue)
