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
                , Temei.view data.temei TemeiMsg
                    -- TODO: Figure this out.
                    --
                    -- This compiles, but there is one thing that’s bothering me about this solution:
                    -- HTML.map docs say:
                    --
                    -- > This should not come in handy too often. Definitely
                    -- > read this before deciding if this[1] is what you want.
                    -- > [1] https://guide.elm-lang.org/reuse/
                    --
                    -- And I’d like to make this right.
                    --
                    -- I went this whole one-message-elm way not to have to map messages, and
                    -- now I’m back to square one. :-\
                    |> Html.map (\v -> tagger v Cmd.none Sub.none)

                -- , DocumentExecutoriu.view data.documentExecutoriu (\v -> c { data | documentExecutoriu = v } Cmd.none Sub.none)
                -- , Actiune.view data.actiune (\v -> c { data | actiune = v })
                ]

        localStyle =
            [ ( "width", "800px" )
            , ( "padding", "48px" )
            ]
    in
        this
