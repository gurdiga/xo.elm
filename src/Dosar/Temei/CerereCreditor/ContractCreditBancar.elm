module Dosar.Temei.CerereCreditor.ContractCreditBancar exposing (Model, Msg, initialModel, update, view)

import Html exposing (Html, fieldset, legend, li, map, text, ul)
import Utils.DocumentScanatTea as DocumentScanatTea
import Widgets.LargeTextField as LargeTextField


type Model
    = Model
        { copia : DocumentScanatTea.Model
        , note : String
        }


initialModel : Model
initialModel =
    Model
        { copia = DocumentScanatTea.initialModel
        , note = ""
        }


view : Model -> Html Msg
view (Model model) =
    fieldset []
        [ legend [] [ text "ContractCreditBancar" ]
        , DocumentScanatTea.view
            { labelText = "Copia:"
            , documentScanat = model.copia
            }
            |> map SetCopia
        , LargeTextField.view "Note:" model.note SetNote
        ]


type Msg
    = SetCopia DocumentScanatTea.Msg
    | SetNote String


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        SetCopia documentScanatTeaMsg ->
            Model { model | copia = DocumentScanatTea.update documentScanatTeaMsg model.copia }

        SetNote v ->
            Model { model | note = v }
