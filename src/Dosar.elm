module Dosar exposing (Dosar, newValue, view)

import Html exposing (Html, h1, div, pre, label, text)
import Dosar.Temei as Temei exposing (Temei)
import Dosar.Pricina as Pricina


type alias Dosar =
    { id : ID
    , temei : Temei
    , order : Pricina.Type
    }


type alias ID =
    String


newValue : Dosar
newValue =
    { id = "001"
    , temei = Temei.newValue
    , order = Pricina.newValue
    }


view : Dosar -> (Dosar -> msg) -> Html msg
view dosar callback =
    div []
        [ h1 [] [ text "Dosar nou" ]
        , Temei.view dosar.temei (\v -> callback { dosar | temei = v })
        ]
