module Widgets.Select3.Css exposing (..)

import Css exposing (..)
import Css.Colors exposing (..)
import MyCss.Mixins


container : Style
container =
    Css.batch
        [ position relative
        , displayFlex
        , width (pct 100)
        , MyCss.Mixins.inheritFont
        ]


listboxContainer : Style
listboxContainer =
    Css.batch
        [ display inlineBlock
        , position relative
        , flexGrow (num 1)
        , MyCss.Mixins.inheritFont
        ]


label : Style
label =
    Css.batch
        [ marginRight (em 0.25) ]


input : Style
input =
    Css.batch
        [ borderStyle solid
        , borderWidth (px 1)
        , padding4 (em 0) (em 1.25) (em 0) (em 0.25)
        , marginTop (px -1)
        , width (pct 100)
        , boxSizing borderBox
        , cursor pointer
        , overflow hidden
        , textOverflow ellipsis
        , inputTextStyle
        ]


inputTextStyle : Style
inputTextStyle =
    Css.batch
        [ MyCss.Mixins.inheritFont
        , color black
        ]


dropdownSymbol : Style
dropdownSymbol =
    Css.batch
        [ position absolute
        , width (em 1)
        , marginLeft (em -1)
        , property "pointer-events" "none"
        , inputTextStyle
        ]


listbox : Style
listbox =
    Css.batch
        [ position absolute
        , margin zero
        , padding zero
        , listStyleType none
        , color black
        , backgroundColor white
        , fontFamilies [ "Alegreya Sans" ]
        , fontSize (Css.rem 1)
        , fontWeight normal
        , fontStyle normal
        , zIndex (int 1)

        -- Thank you https://debois.github.io/elm-mdl/#select
        , property "box-shadow" "0 2px 2px 0 rgba(0,0,0,.14), 0 3px 1px -2px rgba(0,0,0,.2), 0 1px 5px 0 rgba(0,0,0,.12)"
        ]


listboxOption : Style
listboxOption =
    Css.batch
        [ cursor pointer
        , padding4 (em 0) (em 0.5) (em 0) (em 1)
        , hover listboxOptionHover
        ]


listboxOptionHover : List Style
listboxOptionHover =
    [ backgroundColor (hex "eeeeee")
    ]


optionSelectedMarker : Style
optionSelectedMarker =
    Css.batch
        [ position absolute
        , marginLeft (em -1)
        ]
