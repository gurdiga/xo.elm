module UI.Layout exposing (view)

import Html exposing (Html, node, div, header, text)
import Html.Attributes
import Css exposing (..)


type alias Input msg =
    { content : List (Html msg)
    }


view : Input msg -> Html msg
view { content } =
    div []
        [ topBar
        , container content
        ]


topBar : Html msg
topBar =
    header
        [ styles
            [ position fixed
            , top (px 0)
            , width (pct 100)
            , zIndex (int 1)
            , boxShadow4 (px 0) (px headerShadowVerticalSpread) (px 5) (rgba 0 0 0 0.26)
            , padding2 (px headerVerticalPadding) (em 1)
            , --- TODO: add a `font` helper to accept a value of a union type which has the available fonts as options
              fontFamilies [ "Alegreya SC" ]
            , fontSize (px 22)
            , lineHeight (px headerLineHeight)
            , color (hex "fff")
            , backgroundColor (hex "ad1457")
            ]
        ]
        [ Html.text "Executori.Org" ]


headerHeight : Float
headerHeight =
    headerLineHeight + headerVerticalPadding + headerShadowVerticalSpread


headerMarginBottom : Float
headerMarginBottom =
    15


headerLineHeight : Float
headerLineHeight =
    22


headerVerticalPadding : Float
headerVerticalPadding =
    15


headerShadowVerticalSpread : Float
headerShadowVerticalSpread =
    2


styles : List Css.Style -> Html.Attribute msg
styles =
    Css.asPairs >> Html.Attributes.style


container : List (Html msg) -> Html msg
container content =
    node "main"
        [ styles
            [ marginTop (px (headerHeight + headerMarginBottom))
            , padding2 (px 0) (px 20)
            ]
        ]
        content
