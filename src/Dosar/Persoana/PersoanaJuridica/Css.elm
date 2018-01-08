module Dosar.Persoana.PersoanaJuridica.Css exposing (..)

import Css exposing (..)


ul : Style
ul =
    Css.batch
        [ listStyleType none
        , margin zero
        , padding zero
        ]
