module Dosar exposing (Dosar, empty, view)

import Html exposing (Html, h1, div, text)
import MyMaterial.Card as Card
import Dosar.Temei as Temei exposing (Temei)
import Dosar.Actiune as Actiune exposing (Actiune)
import Dosar.DocumentExecutoriu as DocumentExecutoriu exposing (DocumentExecutoriu)


type Dosar
    = Dosar Data


type alias Data =
    { id : String
    , temei : Temei
    , documentExecutoriu : DocumentExecutoriu
    , actiune : Actiune
    }


empty : Dosar
empty =
    Dosar
        { id = "001"
        , temei = Temei.empty
        , documentExecutoriu = DocumentExecutoriu.empty
        , actiune = Actiune.empty
        }


view : Dosar -> (Dosar -> Cmd msg -> Sub msg -> msg) -> Html msg
view (Dosar data) callback =
    let
        c data =
            callback (Dosar data)
    in
        Card.view
            { title = "Dosar nou"
            , maybeSubTitle = Nothing
            , actionButtons = []
            , children =
                [ -- Commenting these out for now, just to save some scrolling.
                  Temei.view data.temei (\v -> c { data | temei = v })
                , DocumentExecutoriu.view data.documentExecutoriu
                    (\v -> c { data | documentExecutoriu = v } Cmd.none Sub.none)
                , Actiune.view
                    data.actiune
                    (\v -> c { data | actiune = v })
                ]
            }
