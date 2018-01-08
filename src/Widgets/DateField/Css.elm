module Widgets.DateField.Css exposing (..)

import Css exposing (..)


input : Style
input =
    Css.batch
        [ marginLeft (em 0.5)
        , fontFamily inherit
        , fontSize inherit
        , fontWeight inherit
        , fontStyle inherit
        ]
