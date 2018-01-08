module Dosar.Persoana.Css exposing (..)

import Css exposing (..)


fieldset : Style
fieldset =
    Css.batch
        [ border (px 0)
        , padding zero
        , margin zero
        ]
