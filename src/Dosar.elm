module Dosar exposing (Model, initialModel, update, Msg, view)

import Html.Styled exposing (toUnstyled, fromUnstyled, Html, h1, section, div, text, select, option, node, button)
import Dosar.Styles as Styles


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
        [ Styles.formular ]
        [ h1 [] [ text "Dosar deschis" ]
        , section []
            [ Temei.view model.temei |> Html.Styled.map SetTemei
            , DocumentExecutoriu.view model.documentExecutoriu |> Html.Styled.map SetDocumentExecutoriu
            ]
        ]
