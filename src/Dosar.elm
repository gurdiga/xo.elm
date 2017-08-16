module Dosar exposing (Dosar, newValue, view)

import Html exposing (Html, h1, div, text)
import Dosar.Temei as Temei exposing (Temei)
import Dosar.Actiune as Actiune exposing (Actiune)
import Dosar.Pricina as Pricina exposing (Pricina)


type Dosar
    = Dosar Data


type alias Data =
    { id : String
    , temei : Temei
    , actiune : Actiune
    , pricina : Pricina
    }


newValue : Dosar
newValue =
    Dosar
        { id = "001"
        , temei = Temei.newValue
        , actiune = Actiune.newValue
        , pricina = Pricina.newValue
        }


view : Dosar -> (Dosar -> Cmd msg -> Sub msg -> msg) -> Html msg
view (Dosar data) callback =
    let
        c data =
            callback (Dosar data)
    in
        div []
            [ h1 [] [ text "Dosar nou" ]
            , Temei.view data.temei (\v -> c { data | temei = v })
            , Actiune.view data.actiune (\v -> c { data | actiune = v })
            ]
