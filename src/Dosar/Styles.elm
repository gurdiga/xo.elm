module Dosar.Styles exposing (..)

import Css exposing (..)
import Html.Styled exposing (Attribute)
import Html.Styled.Attributes exposing (css)


titlu : Attribute msg
titlu =
    css
        [ fontSize (px 34)
        , margin4 zero zero (px 8) zero
        ]


formular : Attribute msg
formular =
    css
        [ property "box-shadow" "0 2px 2px 0 rgba(0,0,0,.14), 0 3px 1px -2px rgba(0,0,0,.2), 0 1px 5px 0 rgba(0,0,0,.12)"
        , property "transition" "box-shadow 250ms ease-in-out 0s"
        , borderRadius (px 2)
        , boxSizing borderBox
        , padding (px 16)
        , backgroundColor (hex "ffffff")
        , width (px 800)
        , padding (px 48)
        ]
