module Dosar.Temei.CerereCreditor exposing (Model, Msg, initialModel, update, view)

import Dosar.Persoana as Persoana
import Dosar.Temei.CerereCreditor.DocumenteContractIpoteca as DocumenteContractIpoteca
import Html exposing (Html, div, fieldset, h1, legend, li, map, text, ul)
import Utils.MyDate as MyDate
import Widgets.CheckboxField as CheckboxField
import Widgets.DateField as DateField


type alias Model =
    { dataDepunere : MyDate.Model
    , creditor : Persoana.Model
    , html : String
    , documenteContractIpoteca : Maybe DocumenteContractIpoteca.Model
    , ui : Ui
    }


type alias Ui =
    { hasDocumenteContractIpoteca : CheckboxField.Model
    }


initialModel : Model
initialModel =
    { dataDepunere = MyDate.empty
    , creditor = Persoana.initialModel
    , html = ""
    , documenteContractIpoteca = Just DocumenteContractIpoteca.initialModel
    , ui =
        { hasDocumenteContractIpoteca = CheckboxField.initialModel False
        }
    }


type Msg
    = SetDataDepunere MyDate.Model
    | SetCreditor Persoana.Msg
    | ToggleDocumenteContractIpoteca CheckboxField.Msg
    | SetDocumenteContractIpoteca DocumenteContractIpoteca.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetDataDepunere v ->
            { model | dataDepunere = v }

        SetCreditor persoanaMsg ->
            { model | creditor = Persoana.update persoanaMsg model.creditor }

        ToggleDocumenteContractIpoteca checkboxFieldMsg ->
            model.ui.hasDocumenteContractIpoteca
                |> CheckboxField.update checkboxFieldMsg
                |> toggleDocumenteContractIpoteca model

        SetDocumenteContractIpoteca documenteContractIpotecaMsg ->
            model.documenteContractIpoteca
                |> Maybe.withDefault DocumenteContractIpoteca.initialModel
                |> DocumenteContractIpoteca.update documenteContractIpotecaMsg
                |> (\v -> { model | documenteContractIpoteca = Just v })


toggleDocumenteContractIpoteca : Model -> CheckboxField.Model -> Model
toggleDocumenteContractIpoteca model newCheckboxFieldModel =
    { model
        | ui = (\ui -> { ui | hasDocumenteContractIpoteca = newCheckboxFieldModel }) model.ui
        , documenteContractIpoteca =
            if CheckboxField.isChecked newCheckboxFieldModel then
                Just DocumenteContractIpoteca.initialModel
            else
                Nothing
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ DateField.view "Data depunerii:" model.dataDepunere SetDataDepunere
        , Persoana.view model.creditor |> map SetCreditor
        , documenteContractIpotecaView model.documenteContractIpoteca
        ]


documenteContractIpotecaView : Maybe DocumenteContractIpoteca.Model -> Html Msg
documenteContractIpotecaView maybeDocumenteContractIpoteca =
    div []
        [ CheckboxField.view "in temeiul contractului de ipoteca"
            (maybeToBool maybeDocumenteContractIpoteca)
            |> map ToggleDocumenteContractIpoteca
        , maybeDocumenteContractIpoteca
            |> Maybe.map (DocumenteContractIpoteca.view >> map SetDocumenteContractIpoteca)
            |> Maybe.withDefault (text "no DocumenteContractIpoteca")
        ]


templateCerere : Model -> List (Html msg)
templateCerere model =
    -- TODO: template?
    [ h1 [] [ text "Cerere de intentare" ]
    , text "TODO"
    ]


maybeToBool : Maybe a -> Bool
maybeToBool maybeA =
    case maybeA of
        Just a ->
            True

        Nothing ->
            False
