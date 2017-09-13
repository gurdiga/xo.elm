module Utils.MyHtml exposing (nonEmpty)

import Html exposing (Html, text)


type alias HtmlTagFunction msg =
    HtmlAttributeList msg -> HtmlNodeList msg -> Html msg


type alias HtmlAttributeList msg =
    List (Html.Attribute msg)


type alias HtmlNodeList msg =
    List (Html msg)


nonEmpty : HtmlTagFunction msg -> HtmlAttributeList msg -> HtmlNodeList msg -> Html msg
nonEmpty tag attrs children =
    if List.length children > 0 then
        tag attrs children
    else
        text ""
