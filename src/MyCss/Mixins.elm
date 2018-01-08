module MyCss.Mixins exposing (..)

import Css exposing (..)


inheritFont : Style
inheritFont =
    Css.batch
        [ fontFamily inherit
        , fontSize inherit
        , fontWeight inherit
        , fontStyle inherit
        ]
