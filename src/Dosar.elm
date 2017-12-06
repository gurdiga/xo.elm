module Dosar exposing (Dosar, Msg, empty, view, update)

import Html exposing (Html, h1, section, div, button, text)
import Html.Attributes exposing (style)
import Dosar.Temei as Temei exposing (Model)
import Dosar.Actiune as Actiune exposing (Actiune)
import Dosar.DocumentExecutoriu as DocumentExecutoriu exposing (DocumentExecutoriu)
import UI.Styles as Styles


type Msg
    = Click
    | TemeiMsg Temei.Msg (Cmd Msg) (Sub Msg)


update : Msg -> Dosar -> Dosar
update msg model =
    case msg of
        Click ->
            Debug.log "model" model

        TemeiMsg msg cmd sub ->
            let
                (Dosar dosar) =
                    model
            in
                Dosar { dosar | temei = Temei.update msg dosar.temei }


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


view : Dosar -> (Msg -> Cmd msg -> Sub msg -> msg) -> Html msg
view (Dosar data) tagger =
    let
        this =
            section [ style (Styles.card ++ localStyle) ]
                [ h1 [ style Styles.display1 ] [ text "Dosar nou" ]

                -- TODO: wire this up
                , Temei.view data.temei

                -- , DocumentExecutoriu.view data.documentExecutoriu (\v -> c { data | documentExecutoriu = v } Cmd.none Sub.none)
                -- , Actiune.view data.actiune (\v -> c { data | actiune = v })
                ]

        localStyle =
            [ ( "width", "800px" )
            , ( "padding", "48px" )
            ]
    in
        this
