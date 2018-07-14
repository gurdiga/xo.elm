module UI.Layout.Styles exposing (..)

import Css exposing (..)
import Html.Styled exposing (Attribute)
import Html.Styled.Attributes exposing (css)


main_ : Attribute msg
main_ =
    css
        [ padding (px 24)
        , fontFamilies [ "Alegreya Sans" ]

        -- , backgroundImage (url "assets/images/bg.png")
        , boxSizing borderBox
        , height (vh 100)
        ]
