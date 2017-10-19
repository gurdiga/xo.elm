module UI.Layout exposing (view)

import Html exposing (Html, div, header, text)
import Html.Attributes exposing (style)


type alias Input msg =
    { content : List (Html msg)
    }


view : Input msg -> Html msg
view { content } =
    div [] ([ topBar ] ++ content)


topBar : Html msg
topBar =
    header
        [ style
            [ ( "position", "fixd" )
            , ( "z-index", "1" )
            , ( "box-shadow", "0 2px 5px rgba(0, 0, 0, 0.26)" )
            , ( "padding", "1em" )
            , ( "font-family", "'Alegreya Sans SC', sans" )
            , ( "color", "white" )
            , ( "background", "#ad1457" )
            ]
        ]
        [ text "Top bar" ]
