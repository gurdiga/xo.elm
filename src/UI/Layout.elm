module UI.Layout exposing (view)

import Html.Styled exposing (Html, node)
import UI.Layout.Styles as Styles


view : List (Html msg) -> Html msg
view children =
    node "main" [ Styles.main_ ] children
