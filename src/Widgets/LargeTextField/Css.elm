module Widgets.LargeTextField.Css exposing (..)

import Css exposing (..)
import MyCss.Mixins


textarea : Style
textarea =
    Css.batch
        [ display block
        , MyCss.Mixins.inheritFont
        , resize none
        ]
