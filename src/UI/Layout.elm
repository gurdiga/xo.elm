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
            [ ( "margin-top", (toString (Styles.appBarHeight + containerMarginTop)) ++ "px" )
            , ( "padding", "0 20px" )
            , ( "font-family", "Alegreya Sans" )
            ]
    in
        this


containerMarginTop : Int
containerMarginTop =
    25
