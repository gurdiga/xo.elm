module Dosar.Temei.DemersInstanta exposing (Model, Msg, initialModel, update, view)

import Dosar.DemersInstanta.Pricina as Pricina
import Html exposing (Html, fieldset, legend, li, map, text, ul)
import Widgets.DocumentScanat3 as DocumentScanat3
import Widgets.Select as Select


type alias Model =
    { pricina : Pricina.Model
    , copia : DocumentScanat3.Model
    }


initialModel : Model
initialModel =
    { pricina = Pricina.initialModel
    , copia = DocumentScanat3.initialModel
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "DemersInstanta" ]
        , ul []
            [ li []
                [ Select.view
                    { label = "Pricina:"
                    , defaultValue = model.pricina
                    , valuesWithLabels = Pricina.valuesWithLabels
                    , onOptionSelected = SetPricina
                    }
                ]
            , li [] [ DocumentScanat3.view "Copia scanată:" SetCopia ]
            ]
        ]


type Msg
    = SetPricina Pricina.Model
    | SetCopia DocumentScanat3.Model


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetPricina v ->
            { model | pricina = v }

        SetCopia v ->
            { model | copia = v }
