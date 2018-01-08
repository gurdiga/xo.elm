module Dosar.Persoana.Css exposing (..)

import Css exposing (..)


fieldset : Style
fieldset =
    Css.batch
        [ borderStyle none
        , padding zero
        , margin zero
        ]
