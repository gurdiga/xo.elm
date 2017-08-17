module Dosar.DocumentExecutoriu exposing (DocumentExecutoriu, newValue, view)

import Html exposing (Html, fieldset, legend, br, text)
import MyDate exposing (MyDate)
import Dosar.DocumentExecutoriu.Pricina as Pricina exposing (Pricina)
import Dosar.DocumentExecutoriu.InstantaDeJudecata as InstantaDeJudecata exposing (InstantaDeJudecata)


type DocumentExecutoriu
    = DocumentExecutoriu Data


type alias Data =
    { instantaEmitatoare : InstantaDeJudecata
    , pricina : Pricina
    , dataPronuntareHotarire : MyDate
    }


newValue : DocumentExecutoriu
newValue =
    DocumentExecutoriu
        { instantaEmitatoare = InstantaDeJudecata.newValue
        , pricina = Pricina.newValue
        , dataPronuntareHotarire = MyDate.newValue
        }


view : DocumentExecutoriu -> (DocumentExecutoriu -> msg) -> Html msg
view documentExecutoriu callback =
    let
        (DocumentExecutoriu data) =
            documentExecutoriu

        c data =
            callback (DocumentExecutoriu data)
    in
        fieldset []
            [ legend [] [ text "DocumentExecutoriu" ]
            , InstantaDeJudecata.view data.instantaEmitatoare (\v -> c { data | instantaEmitatoare = v })
            , br [] []
            , Pricina.view data.pricina (\v -> c { data | pricina = v })
            , br [] []
            , MyDate.view "Data pronunțării hotărîrii:" data.dataPronuntareHotarire (\v -> c { data | dataPronuntareHotarire = v })
            ]
