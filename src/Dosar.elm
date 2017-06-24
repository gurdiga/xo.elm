module Dosar exposing (Dosar, newValue, view)

import Html exposing (Html, h1, div, pre, label, text)
import Html.Attributes exposing (style)
import Dosar.Temei as Temei exposing (Temei)
import Dosar.Order as Order
import Dosar.Person as Person
import Dosar.Cause as Cause
import Warrant
import Select


type alias Dosar =
    { id : ID
    , temei : Temei
    , order : Order.Type
    }


type alias ID =
    String


newValue : Dosar
newValue =
    { id = "001"
    , temei = Temei.newValue
    , order = Order.newValue
    }


view : Dosar -> (Dosar -> msg) -> Html msg
view dosar callback =
    div []
        [ h1 [] [ text "Dosar nou" ]
        , Temei.view dosar.temei (\v -> callback { dosar | temei = v })
        ]
