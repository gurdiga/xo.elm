module Widgets.Select3 exposing (Model, init, view)

import Html exposing (Html, text)


type alias Model a =
    { valuesWithLabels : ValuesWithLabels a
    , isOpened : Bool
    }


type alias ValuesWithLabels a =
    List ( a, String )


init : ValuesWithLabels a -> Model a
init valuesWithLabels =
    { valuesWithLabels = valuesWithLabels
    , isOpened = False
    }


view : Model a -> (Model a -> msg) -> Html msg
view model callback =
    text "Select3"
