module Dosar exposing (Model, Msg, initialModel, update, view)

-- import Html.Events exposing (onInput)

import Dosar.Actiune as Actiune exposing (Model)
import Dosar.DocumentExecutoriu as DocumentExecutoriu
import Dosar.Temei as Temei
import Html exposing (Html, button, div, h1, map, node, option, section, select, text)


type Msg
    = SetTemei Temei.Msg
    | SetDocumentExecutoriu DocumentExecutoriu.Msg
    | SetActiune Actiune.Msg


type alias Model =
    { id : String
    , temei : Temei.Model
    , documentExecutoriu : DocumentExecutoriu.Model
    , actiune : Actiune.Model
    }


initialModel : Model
initialModel =
    { id = "001"
    , temei = Temei.initialModel
    , documentExecutoriu = DocumentExecutoriu.initialModel
    , actiune = Actiune.initialModel
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetTemei temeiMsg ->
            { model | temei = Temei.update temeiMsg model.temei }

        SetDocumentExecutoriu documentExecutoriuMsg ->
            { model | documentExecutoriu = DocumentExecutoriu.update documentExecutoriuMsg model.documentExecutoriu }

        SetActiune actiuneMsg ->
            { model | actiune = Actiune.update actiuneMsg model.actiune }


view : Model -> Html Msg
view model =
    node "main"
        []
        [ h1 [] [ text "Dosar deschis" ]
        , section []
            [ Temei.view model.temei |> map SetTemei
            , DocumentExecutoriu.view model.documentExecutoriu |> map SetDocumentExecutoriu
            , Actiune.view model.actiune |> map SetActiune
            ]
        ]
