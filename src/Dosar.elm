module Dosar exposing (Model, initialModel, update, Msg, view)

import Dosar.Css
import Html exposing (Html, h1, section, div, select, option, button, text, node)
import Html.Attributes exposing (style)


-- import Html.Events exposing (onInput)

import Dosar.Temei as Temei exposing (Model)
import Dosar.Actiune as Actiune exposing (Actiune)
import Dosar.DocumentExecutoriu as DocumentExecutoriu exposing (DocumentExecutoriu)


-- import UI.Styles as Styles


type Model
    = Model
        { id : String
        , temei : Temei.Model
        , documentExecutoriu : DocumentExecutoriu
        , actiune : Actiune
        }


initialModel : Model
initialModel =
    Model
        { id = "001"
        , temei = Temei.initialModel
        , documentExecutoriu = DocumentExecutoriu.empty
        , actiune = Actiune.empty
        }


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        UpdateTemei temeiMsg ->
            Model { model | temei = Temei.update temeiMsg model.temei }


type Msg
    = UpdateTemei Temei.Msg


view : Model -> Html Msg
view (Model model) =
    node "main"
        [ style Dosar.Css.formular ]
        [ h1 [] [ text "Dosar deschis" ]
        , section []
            [ node "hgroup"
                []
                [ Temei.view model.temei |> Html.map UpdateTemei ]
            ]
        ]
