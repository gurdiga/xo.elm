module Dosar exposing (Dosar, empty, view)

import Html exposing (Html, h1, section, div, text)
import Html.Attributes exposing (style)
import Dosar.Temei as Temei exposing (Model)
import Dosar.Actiune as Actiune exposing (Actiune)
import Dosar.DocumentExecutoriu as DocumentExecutoriu exposing (DocumentExecutoriu)
import UI.Styles as Styles


type Dosar
    = Dosar Data


type alias Data =
    { id : String
    , temei : Temei.Model
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
        this =
            section [ style (Styles.card ++ localStyle) ]
                [ h1 [ style Styles.display1 ] [ text "Dosar nou" ]
                , Temei.view data.temei (\v -> c { data | temei = v })
                , DocumentExecutoriu.view data.documentExecutoriu (\v -> c { data | documentExecutoriu = v } Cmd.none Sub.none)
                , Actiune.view data.actiune (\v -> c { data | actiune = v })
                ]

        localStyle =
            [ ( "width", "800px" )
            , ( "padding", "48px" )
            ]

        c data =
            callback (Dosar data)
    in
        this
