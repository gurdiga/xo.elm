module UI.Layout exposing (view)

import Html exposing (Html, node)


view : List (Html msg) -> Html msg
view children =
    node "main" [] children
