module Dosar.Temei.DemersInstanta exposing (Model, Msg, initialModel, update, view)

import Dosar.DemersInstanta.Pricina as Pricina
import Html.Styled exposing (Html, fieldset, legend, li, map, text, ul)
import Utils.DocumentScanatTea as DocumentScanatTea
import Widgets.Select3 as Select3


type Msg
    = SetPricina (Select3.Msg Pricina.Model)
    | SetCopia DocumentScanatTea.Msg


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        SetPricina select3Msg ->
            receivePricina (Model model) (Select3.update select3Msg model.ui.pricinaSelect)

        SetCopia documentScanatTeaMsg ->
            Model { model | copia = DocumentScanatTea.update documentScanatTeaMsg model.copia }


receivePricina : Model -> Select3.Model Pricina.Model -> Model
receivePricina (Model ({ ui } as model)) newSelect =
    Model
        { model
            | ui = { ui | pricinaSelect = newSelect }
            , pricina = Select3.selectedValue newSelect
        }


type Model
    = Model
        { pricina : Pricina.Model
        , copia : DocumentScanatTea.Model
        , ui : Ui
        }


type alias Ui =
    { pricinaSelect : Select3.Model Pricina.Model
    }


initialModel : Model
initialModel =
    Model
        { pricina = Pricina.initialModel
        , copia = DocumentScanatTea.initialModel
        , ui =
            { pricinaSelect = Select3.initialModel Pricina.initialModel Pricina.valuesWithLabels
            }
        }


view : Model -> Html Msg
view (Model model) =
    fieldset []
        [ legend [] [ text "DemersInstanta" ]
        , ul []
            [ li [] [ Select3.view "Pricina:" model.ui.pricinaSelect |> map SetPricina ]
            , li [] [ DocumentScanatTea.view { labelText = "Copia scanată:", documentScanat = model.copia } |> map SetCopia ]
            ]
        ]
