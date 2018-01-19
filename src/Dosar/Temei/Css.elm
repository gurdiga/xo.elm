module Dosar.Temei.Css exposing (..)

import Css exposing (..)
import Css.Colors exposing (..)


section : Style
section =
    Css.batch
        [ width (px 400)
        ]


sectionTitle : Style
sectionTitle =
    Css.batch
        [ padding (px 8)
        , color white
        , backgroundColor (hex "666666")
        , fontSize (px 23)
        , fontWeight bold
        , displayFlex
        , marginBottom (px 8)
        ]
