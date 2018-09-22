module Dosar.Temei.CerereCreditor.ContractCreditBancar exposing (Model, Msg, initialModel, update, view)

import Html exposing (Html, fieldset, legend, li, map, text, ul)
import Utils.DocumentScanat2 as DocumentScanat2
import Widgets.LargeTextField as LargeTextField


type Model
    = Model
        { copia : DocumentScanat2.Model
        , note : String
        }


initialModel : Model
initialModel =
    Model
        { copia = DocumentScanat2.initialModel
        , note = ""
        }


view : Model -> Html Msg
view (Model model) =
    fieldset []
        [ legend [] [ text "ContractCreditBancar" ]
        , DocumentScanat2.view "Copia:" model.copia |> map SetCopia
        , LargeTextField.view "Note:" model.note SetNote
        ]


type Msg
    = SetCopia DocumentScanat2.Msg
    | SetNote String


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        SetCopia documentScanatTeaMsg ->
            Model { model | copia = DocumentScanat2.update documentScanatTeaMsg model.copia }

        SetNote v ->
            Model { model | note = v }
