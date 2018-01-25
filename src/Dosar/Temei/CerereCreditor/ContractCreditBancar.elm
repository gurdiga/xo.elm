module Dosar.Temei.CerereCreditor.ContractCreditBancar exposing (Model, Msg, initialModel, update, view)

import Html.Styled exposing (Html, fieldset, legend, li, map, text, ul)
import Utils.DocumentScanatTea as DocumentScanatTea
import Widgets.LargeTextField as LargeTextField


type Msg
    = SetCopia DocumentScanatTea.Msg
    | SetNote LargeTextField.Msg


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        SetCopia documentScanatTeaMsg ->
            Model { model | copia = DocumentScanatTea.update documentScanatTeaMsg model.copia }

        SetNote largeTextFieldMsg ->
            Model { model | note = LargeTextField.update largeTextFieldMsg model.note }


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
        , LargeTextField.view "Note:" model.note |> map SetNote
        ]
