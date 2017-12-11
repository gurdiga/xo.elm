module UI.Layout exposing (view)

import Html exposing (Html, node, div, header, text)
import Html.Attributes exposing (style)


view : List (Html msg) -> Html msg
view children =
    let
        this =
            node "main" [ style styles ] children

        styles =
            [ ( "padding", "24px" )
            , ( "font-family", "Alegreya Sans" )
            , ( "background-image", "url(/assets/images/bg.png)" )
            ]
    in
        this


appBarSpacingBottom : Int
appBarSpacingBottom =
    24
