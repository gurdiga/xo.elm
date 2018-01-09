module Utils.MyHtmlEvents
    exposing
        ( onClick
        , onFocus
        , onKeyDown
        , onMouseOut
        , onMouseOver
        )

import Html
import Html.Events
import Json.Decode


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


onKeyDown : (Int -> msg) -> Html.Attribute msg
onKeyDown tagger =
    Html.Events.on "keydown" (Json.Decode.map tagger Html.Events.keyCode)
