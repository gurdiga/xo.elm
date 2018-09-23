module Dosar.Temei.PreluareDocumentExecutoriuStramutat exposing (Model, Msg, initialModel, update, view)

import Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActeEfectuateAnterior as ActeEfectuateAnterior
import Dosar.Temei.PreluareDocumentExecutoriuStramutat.CauzaStramutare as CauzaStramutare
import Html exposing (Html, fieldset, h1, legend, li, map, p, text, ul)
import Widgets.DocumentScanat3 as DocumentScanat3
import Widgets.LargeTextField as LargeTextField
import Widgets.Select as Select


type alias Model =
    { cauzaStramutare : CauzaStramutare.Model
    , copieIncheiereStramutare : DocumentScanat3.Model
    , acteEfectuateAnterior : ActeEfectuateAnterior.Model
    , note : String
    , actPreluare : String
    }


initialModel : Model
initialModel =
    { cauzaStramutare = CauzaStramutare.initialModel
    , copieIncheiereStramutare = DocumentScanat3.initialModel
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
            , li [] [ DocumentScanat3.view "Copia încheierii:" SetCopieIncheiereStramutare ]
            , li [] [ ActeEfectuateAnterior.view model.acteEfectuateAnterior |> map SetActeEfectuatAnterior ]
            , li [] [ LargeTextField.view "Note:" model.note SetNote ]
            , li [] [ LargeTextField.view "Act preluare:" model.actPreluare SetActPreluare ]
            ]
        ]


viewCauzaStramutarii : CauzaStramutare.Model -> Html Msg
viewCauzaStramutarii cauzaStramutare =
    Select.view
        { label = "Cauza strămutării:"
        , valuesWithLabels = CauzaStramutare.valuesWithLabels
        , defaultValue = cauzaStramutare
        , onOptionSelected = SetCauzaStramutare
        }


type Msg
    = SetCauzaStramutare CauzaStramutare.Model
    | SetCopieIncheiereStramutare DocumentScanat3.Model
    | SetActeEfectuatAnterior ActeEfectuateAnterior.Msg
    | SetNote String
    | SetActPreluare String


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetCauzaStramutare v ->
            { model | cauzaStramutare = v }

        SetCopieIncheiereStramutare v ->
            { model | copieIncheiereStramutare = v }

        SetActeEfectuatAnterior acteEfectuateAnteriorMsg ->
            { model | acteEfectuateAnterior = ActeEfectuateAnterior.update acteEfectuateAnteriorMsg model.acteEfectuateAnterior }

        SetNote v ->
            { model | note = v }

        SetActPreluare v ->
            { model | actPreluare = v }
