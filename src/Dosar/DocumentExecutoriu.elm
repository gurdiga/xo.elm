module Dosar.DocumentExecutoriu exposing (DocumentExecutoriu, newValue, view)

import Html exposing (Html, fieldset, legend, text)
import Dosar.DocumentExecutoriu.InstantaDeJudecata as InstantaDeJudecata exposing (InstantaDeJudecata)


type DocumentExecutoriu
    = DocumentExecutoriu Data


type alias Data =
    { instantaEmitatoare : InstantaDeJudecata
    }


newValue : DocumentExecutoriu
newValue =
    DocumentExecutoriu
        { instantaEmitatoare = InstantaDeJudecata.newValue
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
            ]
