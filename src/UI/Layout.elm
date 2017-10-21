module UI.Layout exposing (view)

import Html exposing (Html, node, div, header, text)
import Html.Attributes exposing (style)
import UI.Styles as Styles


type alias Input msg =
    { content : List (Html msg)
    }


view : Input msg -> Html msg
view { content } =
    div []
        [ appBar
        , container content
        ]


appBar : Html msg
appBar =
    header
        [ style Styles.appBar ]
        [ Html.text "Executori.Org" ]


container : List (Html msg) -> Html msg
container content =
    let
        this =
            node "main" [ style localStyle ] content

        localStyle =
            [ ( "padding", "0 24px" )
            , ( "padding-top", (toString (Styles.appBarHeight + appBarSpacingBottom)) ++ "px" )
            , ( "font-family", "Alegreya Sans" )
            , ( "background-image", "url(assets/images/bg.png)" )
            ]
    in
        this


appBarSpacingBottom : Int
appBarSpacingBottom =
    24
