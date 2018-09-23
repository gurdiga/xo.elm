module Dosar.Temei.PreluareDocumentExecutoriuStramutat exposing (Model, Msg, initialModel, update, view)

import Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActeEfectuateAnterior as ActeEfectuateAnterior
import Dosar.Temei.PreluareDocumentExecutoriuStramutat.CauzaStramutare as CauzaStramutare
import Html exposing (Html, fieldset, h1, legend, li, map, p, text, ul)
import Widgets.DocumentScanat2 as DocumentScanat2
import Widgets.LargeTextField as LargeTextField
import Widgets.Select as Select


type alias Model =
    { cauzaStramutare : CauzaStramutare.Model
    , copieIncheiereStramutare : DocumentScanat2.Model
    , acteEfectuateAnterior : ActeEfectuateAnterior.Model
    , note : String
    , actPreluare : String
    }


initialModel : Model
initialModel =
    { cauzaStramutare = CauzaStramutare.initialModel
    , copieIncheiereStramutare = DocumentScanat2.initialModel
    , acteEfectuateAnterior = ActeEfectuateAnterior.initialModel
    , note = ""
    , actPreluare = ""
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "PreluareDocumentExecutoriuStramutat" ]
        , ul []
            [ li [] [ viewCauzaStramutarii model.cauzaStramutare ]
            , li [] [ DocumentScanat2.view "Copia încheierii:" model.copieIncheiereStramutare |> map SetCopieIncheiereStramutare ]
            , li [] [ ActeEfectuateAnterior.view model.acteEfectuateAnterior |> map SetActeEfectuatAnterior ]
            , li [] [ LargeTextField.view "Note:" model.note SetNote ]
            , li [] [ LargeTextField.view "Act preluare:" model.actPreluare SetActPreluare ]
            ]
        ]


viewCauzaStramutarii : CauzaStramutare.Model -> Html Msg
viewCauzaStramutarii cauzaStramutare =
    Select.view <|
        Select.config
            { label = "Cauza strămutării:"
            , valuesWithLabels = CauzaStramutare.valuesWithLabels
            , defaultValue = cauzaStramutare
            , onInput = SetCauzaStramutare
            }


type Msg
    = SetCauzaStramutare CauzaStramutare.Model
    | SetCopieIncheiereStramutare DocumentScanat2.Msg
    | SetActeEfectuatAnterior ActeEfectuateAnterior.Msg
    | SetNote String
    | SetActPreluare String


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetCauzaStramutare v ->
            { model | cauzaStramutare = v }

        SetCopieIncheiereStramutare documentScanat2Msg ->
            { model | copieIncheiereStramutare = DocumentScanat2.update documentScanat2Msg model.copieIncheiereStramutare }

        SetActeEfectuatAnterior acteEfectuateAnteriorMsg ->
            { model | acteEfectuateAnterior = ActeEfectuateAnterior.update acteEfectuateAnteriorMsg model.acteEfectuateAnterior }

        SetNote v ->
            { model | note = v }

        SetActPreluare v ->
            { model | actPreluare = v }
