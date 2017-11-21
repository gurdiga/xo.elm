module UI.Layout exposing (view)

import Html exposing (Html, node, div, header, text)
import Html.Attributes exposing (style)


type alias Input msg =
    { content : List (Html msg)
    }


view : Input msg -> Html msg
view { content } =
    container content


container : List (Html msg) -> Html msg
container content =
    let
        this =
            node "main" [ style styles ] content

        styles =
            [ ( "padding", "24px" )
            , ( "font-family", "Alegreya Sans" )
            , ( "background-image", "url(assets/images/bg.png)" )
            ]
    in
        this


appBarSpacingBottom : Int
appBarSpacingBottom =
    24
