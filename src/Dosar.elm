module Dosar exposing (Model, Msg, initialModel, update, view)

-- import Html.Events exposing (onInput)

import Dosar.DocumentExecutoriu as DocumentExecutoriu
import Dosar.Styles as Styles
import Dosar.Temei as Temei
import Html.Styled exposing (Html, button, div, fromUnstyled, h1, map, node, option, section, select, text, toUnstyled)


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
            [ Temei.view model.temei |> map SetTemei
            , DocumentExecutoriu.view model.documentExecutoriu |> map SetDocumentExecutoriu
            ]
        ]
