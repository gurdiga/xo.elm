module UI.Styles
    exposing
        ( appBar
        , appBarHeight
        , card
        )


appBar : List ( String, String )
appBar =
    [ ( "position", "fixed" )
    , ( "top", "0" )
    , ( "width", "100%" )
    , ( "z-index", "1" )
    , ( "box-shadow", "0 " ++ (toString appBarShadowVerticalSpread) ++ "px 5px rgba(0,0,0,0.26)" )
    , ( "padding", (toString appBarVerticalPadding) ++ "px 16px" )
    , ( "font-family", "Alegreya SC" )
    , ( "font-size", "22px" )
    , ( "line-height", (toString appBarLineHeight) ++ "px" )
    , ( "color", "white" )
    , ( "background-color", "#ad1457" )
    ]


appBarHeight : Int
appBarHeight =
    appBarLineHeight + appBarVerticalPadding * 2 + appBarShadowVerticalSpread


appBarLineHeight : Int
appBarLineHeight =
    22


appBarVerticalPadding : Int
appBarVerticalPadding =
    20


appBarShadowVerticalSpread : Int
appBarShadowVerticalSpread =
    4


card : List ( String, String )
card =
    [ ( "box-shadow", "0 2px 2px 0 rgba(0,0,0,.14), 0 3px 1px -2px rgba(0,0,0,.2), 0 1px 5px 0 rgba(0,0,0,.12)" )
    , ( "transition", "box-shadow 250ms ease-in-out 0s" )
    , ( "border-radius", "2px" )
    , ( "box-sizing", "border-box" )
    , ( "padding", "16px" )
    ]
