module Widgets.Select3.Css exposing (..)


container : List ( String, String )
container =
    [ ( "position", "relative" )
    , ( "display", "flex" )
    , ( "width", "100%" )
    ]


listboxContainer : List ( String, String )
listboxContainer =
    [ ( "display", "inline-block" )
    , ( "position", "relative" )
    , ( "flex-grow", "1" )
    ]


label : List ( String, String )
label =
    [ ( "margin-right", "0.25em" ) ]


input : List ( String, String )
input =
    [ ( "border-style", "solid" )
    , ( "border-width", "1px" )
    , ( "padding", "0 1.25em 0 0.25em" )
    , ( "margin-top", "-1px" )
    , ( "width", "100%" )
    , ( "box-sizing", "border-box" )
    , ( "cursor", "pointer" )
    , ( "overflow", "hidden" )
    , ( "text-overflow", "ellipsis" )
    ]


dropdownSymbol : List ( String, String )
dropdownSymbol =
    [ ( "position", "absolute" )
    , ( "width", "1em" )
    , ( "margin-left", "-1em" )
    , ( "pointer-events", "none" )
    ]


listbox : List ( String, String )
listbox =
    [ ( "position", "absolute" )
    , ( "margin", "0" )
    , ( "padding", "0" )
    , ( "list-style-type", "none" )
    , ( "color", "black" )
    , ( "background-color", "white" )
    , ( "font", "1rem 'Alegreya Sans'" )
    , ( "z-index", "1" )

    -- Thank you https://debois.github.io/elm-mdl/#select
    , ( "box-shadow", "0 2px 2px 0 rgba(0,0,0,.14), 0 3px 1px -2px rgba(0,0,0,.2), 0 1px 5px 0 rgba(0,0,0,.12)" )
    ]


listboxOption : List ( String, String )
listboxOption =
    [ ( "cursor", "pointer" )
    , ( "padding", "0px 0.25em 0px 1em" )
    ]


optionSelectedMarker : List ( String, String )
optionSelectedMarker =
    [ ( "position", "absolute" )
    , ( "margin-left", "-1em" )
    ]


optionHoverStyles : List ( String, String )
optionHoverStyles =
    [ ( "background", "#eee" )
    ]
