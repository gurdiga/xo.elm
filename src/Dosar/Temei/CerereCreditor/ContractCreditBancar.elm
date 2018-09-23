module Dosar.Temei.CerereCreditor.ContractCreditBancar exposing (Model, Msg, initialModel, update, view)

import Html exposing (Html, fieldset, legend, li, map, text, ul)
import Widgets.DocumentScanat3 as DocumentScanat3
import Widgets.LargeTextField as LargeTextField


type Model
    = Model
        { copia : DocumentScanat3.Model
        , note : String
        }


initialModel : Model
initialModel =
    Model
        { copia = DocumentScanat3.initialModel
        , note = ""
        }


view : Model -> Html Msg
view (Model model) =
    fieldset []
        [ legend [] [ text "ContractCreditBancar" ]
        , DocumentScanat3.view "Copia:" SetCopia
        , LargeTextField.view "Note:" model.note SetNote
        ]


type Msg
    = SetCopia DocumentScanat3.Model
    | SetNote String


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        SetCopia v ->
            Model { model | copia = v }

        SetNote v ->
            Model { model | note = v }
