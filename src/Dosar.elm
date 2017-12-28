module Dosar exposing (Model, initialModel, update, Msg, view)

import Dosar.Css
import Html exposing (Html, h1, section, div, select, option, button, text, node)
import Html.Attributes exposing (style)


-- import Html.Events exposing (onInput)

import Dosar.Temei as Temei
import Dosar.DocumentExecutoriu as DocumentExecutoriu


-- import Dosar.Actiune as Actiune exposing (Actiune)
-- import UI.Styles as Styles


type Msg
    = SetTemei Temei.Msg
    | SetDocumentExecutoriu DocumentExecutoriu.Msg


type Model
    = Model
        { id : String
        , temei : Temei.Model
        , documentExecutoriu : DocumentExecutoriu.Model

        --
        -- TODO: Continue here
        --
        --
        -- , actiune : Actiune
        }


initialModel : Model
initialModel =
    Model
        { id = "001"
        , temei = Temei.initialModel
        , documentExecutoriu = DocumentExecutoriu.empty

        -- , actiune = Actiune.empty
        }


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        SetTemei temeiMsg ->
            Model { model | temei = Temei.update temeiMsg model.temei }

        SetDocumentExecutoriu documentExecutoriuMsg ->
            Model { model | documentExecutoriu = DocumentExecutoriu.update documentExecutoriuMsg model.documentExecutoriu }


view : Model -> Html Msg
view (Model model) =
    node "main"
        [ style Dosar.Css.formular ]
        [ h1 [] [ text "Dosar deschis" ]
        , section []
            [ Temei.view model.temei |> Html.map SetTemei
            , DocumentExecutoriu.view model.documentExecutoriu |> Html.map SetDocumentExecutoriu
            ]
        ]
