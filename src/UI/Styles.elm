module UI.Styles
    exposing
        ( card
        , display1
        , fieldLabel
        , inheritFont
        )


card : List ( String, String )
card =
    [ ( "box-shadow", "0 2px 2px 0 rgba(0,0,0,.14), 0 3px 1px -2px rgba(0,0,0,.2), 0 1px 5px 0 rgba(0,0,0,.12)" )
    , ( "transition", "box-shadow 250ms ease-in-out 0s" )
    , ( "border-radius", "2px" )
    , ( "box-sizing", "border-box" )
    , ( "padding", "16px" )
    , ( "background", "white" )
    ]


display1 : List ( String, String )
display1 =
    [ ( "font-size", "34px" )
    , ( "margin", "0 0 8px 0" )
    ]


fieldLabel : List ( String, String )
fieldLabel =
    [ ( "margin-right", "8px" ) ]


inheritFont : List ( String, String )
inheritFont =
    [ ( "font-family", "inherit" )
    , ( "font-size", "inherit" )
    , ( "font-weight", "inherit" )
    , ( "font-style", "inherit" )
    , ( "color", "inherit" )
    , ( "line-height", "inherit" )
    , ( "background-color", "inherit" )
    ]
