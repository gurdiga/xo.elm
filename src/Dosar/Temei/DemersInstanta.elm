module Dosar.Temei.DemersInstanta exposing (Model, Msg, initialModel, update, view)

import Dosar.DemersInstanta.Pricina as Pricina
import Html exposing (Html, fieldset, legend, li, map, text, ul)
import Utils.DocumentScanat2 as DocumentScanat2
import Widgets.Select as Select


type alias Model =
    { pricina : Pricina.Model
    , copia : DocumentScanat2.Model
    }


initialModel : Model
initialModel =
    { pricina = Pricina.initialModel
    , copia = DocumentScanat2.initialModel
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "DemersInstanta" ]
        , ul []
            [ li []
                [ Select.view <|
                    Select.config
                        { label = "Pricina:"
                        , defaultValue = model.pricina
                        , valuesWithLabels = Pricina.valuesWithLabels
                        , onInput = SetPricina
                        }
                ]
            , li [] [ DocumentScanat2.view "Copia scanată:" model.copia |> map SetCopia ]
            ]
        ]


type Msg
    = SetPricina Pricina.Model
    | SetCopia DocumentScanat2.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetPricina v ->
            { model | pricina = v }

        SetCopia documentScanatTeaMsg ->
            { model | copia = DocumentScanat2.update documentScanatTeaMsg model.copia }
