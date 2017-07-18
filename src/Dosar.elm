module Dosar exposing (Dosar, newValue, view)

import Html exposing (Html, h1, div, text)
import Dosar.Temei as Temei exposing (Temei)
import Dosar.Pricina as Pricina exposing (Pricina)


type alias Dosar =
    { id : ID
    , temei : Temei
    , order : Pricina
    }


type alias ID =
    String


newValue : Dosar
newValue =
    { id = "001"
    , temei = Temei.newValue
    , order = Pricina.newValue
    }


view : (Cmd msg -> Dosar -> msg) -> Dosar -> Html msg
view callback dosar =
    div []
        [ h1 [] [ text "Dosar nou" ]
        , Temei.view (\cmd v -> callback cmd { dosar | temei = v }) dosar.temei
        ]
