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
    , ( "padding", "0 0.25em" )
    , ( "margin-top", "-1px" )
    , ( "width", "100%" )
    , ( "box-sizing", "border-box" )
    ]


listbox : List ( String, String )
listbox =
    [ ( "position", "absolute" )
    , ( "margin", "0" )
    , ( "padding", "0" )
    , ( "list-style-type", "none" )
    ]


listboxOption : List ( String, String )
listboxOption =
    [ ( "cursor", "pointer" ) ]
