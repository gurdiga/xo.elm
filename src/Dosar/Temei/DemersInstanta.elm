module Dosar.Temei.DemersInstanta exposing (Model, Msg, initialModel, update, view)

import Dosar.DemersInstanta.Pricina as Pricina
import Html exposing (Html, fieldset, legend, li, map, text, ul)
import Utils.DocumentScanatTea as DocumentScanatTea
import Widgets.Select4 as Select4


type alias Model =
    { pricina : Pricina.Model
    , copia : DocumentScanatTea.Model
    }


initialModel : Model
initialModel =
    { pricina = Pricina.initialModel
    , copia = DocumentScanatTea.initialModel
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "DemersInstanta" ]
        , ul []
            [ li []
                [ Select4.view <|
                    Select4.config
                        { label = "Pricina:"
                        , defaultValue = model.pricina
                        , valuesWithLabels = Pricina.valuesWithLabels
                        , onInput = SetPricina
                        }
                ]
            , li [] [ DocumentScanatTea.view { labelText = "Copia scanată:", documentScanat = model.copia } |> map SetCopia ]
            ]
        ]


type Msg
    = SetPricina Pricina.Model
    | SetCopia DocumentScanatTea.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetPricina v ->
            { model | pricina = v }

        SetCopia documentScanatTeaMsg ->
            { model | copia = DocumentScanatTea.update documentScanatTeaMsg model.copia }
