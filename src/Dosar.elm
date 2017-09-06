module Dosar exposing (Model, Msg, empty, update, view)

import Html exposing (Html, h1, div, text)
import Dosar.Temei as Temei exposing (Temei)
import Dosar.Actiune as Actiune exposing (Actiune)
import Dosar.DocumentExecutoriu as DocumentExecutoriu exposing (DocumentExecutoriu)


type Model
    = Dosar Data


type alias Data =
    { id : String
    , temei : Temei
    , documentExecutoriu : DocumentExecutoriu
    , actiune : Actiune
    }


empty : Model
empty =
    Dosar
        { id = "001"
        , temei = Temei.empty
        , documentExecutoriu = DocumentExecutoriu.empty
        , actiune = Actiune.empty
        }


type Msg
    = SetTemei Temei
    | SetDocumentExecutoriu DocumentExecutoriu
    | SetActiune Actiune


update : Msg -> Model -> Model
update msg (Dosar data) =
    case msg of
        SetTemei v ->
            Dosar { data | temei = v }

        SetDocumentExecutoriu v ->
            Dosar { data | documentExecutoriu = v }

        SetActiune v ->
            Dosar { data | actiune = v }


view : Model -> (Model -> Msg) -> Html Msg
view (Dosar data) callback =
    div []
        [ h1 [] [ text "Dosar nou" ]
        , Temei.view data.temei (\v cmd sub -> SetTemei v)
        , DocumentExecutoriu.view data.documentExecutoriu SetDocumentExecutoriu
        , Actiune.view data.actiune (\v cmd sub -> SetActiune v)
        ]
