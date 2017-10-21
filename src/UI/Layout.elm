module UI.Layout exposing (view)

import Html exposing (Html, node, div, header, text)
import Html.Attributes exposing (style)


type alias Input msg =
    { content : List (Html msg)
    }


view : Input msg -> Html msg
view { content } =
    div []
        [ topBar
        , container content
        ]


topBar : Html msg
topBar =
    header
        [ style
            [ ( "position", "fixed" )
            , ( "top", "0" )
            , ( "width", "100%" )
            , ( "z-index", "1" )
            , ( "box-shadow", "0 " ++ (toString topBarShadowVerticalSpread) ++ "px 5px rgba(0,0,0,0.26)" )
            , ( "padding", (toString topBarVerticalPadding) ++ "px 16px" )
            , ( "font-family", "Alegreya SC" )
            , ( "font-size", "22px" )
            , ( "line-height", (toString topBarLineHeight) ++ "px" )
            , ( "color", "white" )
            , ( "background-color", "#ad1457" )
            ]
        ]
        [ Html.text "Executori.Org" ]


container : List (Html msg) -> Html msg
container content =
    node "main"
        [ style
            [ ( "margin-top", (toString (topBarHeight + topBarMarginBottom)) ++ "px" )
            , ( "padding", "0 20px" )
            , ( "font-family", "Alegreya Sans" )
            ]
        ]
        content


topBarHeight : Float
topBarHeight =
    topBarLineHeight + topBarVerticalPadding * 2 + topBarShadowVerticalSpread


topBarMarginBottom : Float
topBarMarginBottom =
    25


topBarLineHeight : Float
topBarLineHeight =
    22


topBarVerticalPadding : Float
topBarVerticalPadding =
    20


topBarShadowVerticalSpread : Float
topBarShadowVerticalSpread =
    4
