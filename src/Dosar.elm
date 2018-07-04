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


type alias Model =
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
    { id = "001"
    , temei = Temei.initialModel
    , documentExecutoriu = DocumentExecutoriu.empty

    -- , actiune = Actiune.empty
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetTemei temeiMsg ->
            { model | temei = Temei.update temeiMsg model.temei }

        SetDocumentExecutoriu documentExecutoriuMsg ->
            { model | documentExecutoriu = DocumentExecutoriu.update documentExecutoriuMsg model.documentExecutoriu }


view : Model -> Html Msg
view model =
    node "main"
        [ Styles.formular ]
        [ h1 [] [ text "Dosar deschis" ]
        , section []
            [ Temei.view model.temei |> map SetTemei
            , DocumentExecutoriu.view model.documentExecutoriu |> map SetDocumentExecutoriu
            ]
        ]
