module Widgets.TextField.Css exposing (..)

import Css exposing (..)
import MyCss.Mixins


input : Style
input =
    Css.batch
        [ marginLeft (em 0.5)
        , MyCss.Mixins.inheritFont
        ]
