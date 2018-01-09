module Utils.MyHtml exposing (whenNonEmpty, whenNonNothing, whenNothing, whenTrue)

import Html exposing (Html, text)


whenNonNothing : Maybe a -> (a -> Html msg) -> Html msg
whenNonNothing maybeV renderer =
    case maybeV of
        Just v ->
            renderer v

        Nothing ->
            text ""


whenNothing : Maybe a -> (Maybe a -> Html msg) -> Html msg
whenNothing maybeV renderer =
    case maybeV of
        Nothing ->
            renderer Nothing

        Just _ ->
            text ""


whenNonEmpty : List a -> (List a -> Html msg) -> Html msg
whenNonEmpty list renderer =
    if List.isEmpty list then
        text ""
    else
        renderer list


whenTrue : Bool -> (Bool -> Html msg) -> Html msg
whenTrue v renderer =
    if v == True then
        renderer v
    else
        text ""
