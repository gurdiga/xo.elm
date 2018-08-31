module Dosar.Temei.CerereCreditor exposing (Model, Msg, initialModel, update, view)

import Dosar.Persoana as Persoana
import Dosar.Temei.CerereCreditor.DocumenteContractIpoteca as DocumenteContractIpoteca
import Html exposing (Html, div, fieldset, h1, legend, li, map, text, ul)
import Utils.MyDate as MyDate
import Widgets.CheckboxField as CheckboxField
import Widgets.DateField as DateField


type Model
    = Model
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
    Model
        { dataDepunere = MyDate.empty
        , creditor = Persoana.initialModel
        , html = ""
        , documenteContractIpoteca = Just DocumenteContractIpoteca.initialModel
        , ui =
            { hasDocumenteContractIpoteca = CheckboxField.initialModel False
            }
        }


type Msg
    = SetDataDepunere DateField.Msg
    | SetCreditor Persoana.Msg
    | ToggleDocumenteContractIpoteca CheckboxField.Msg
    | SetDocumenteContractIpoteca DocumenteContractIpoteca.Msg


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        SetDataDepunere dateFieldMsg ->
            Model { model | dataDepunere = DateField.update dateFieldMsg model.dataDepunere }

        SetCreditor persoanaMsg ->
            Model { model | creditor = Persoana.update persoanaMsg model.creditor }

        ToggleDocumenteContractIpoteca checkboxFieldMsg ->
            model.ui.hasDocumenteContractIpoteca
                |> CheckboxField.update checkboxFieldMsg
                |> toggleDocumenteContractIpoteca (Model model)

        SetDocumenteContractIpoteca documenteContractIpotecaMsg ->
            model.documenteContractIpoteca
                |> Maybe.withDefault DocumenteContractIpoteca.initialModel
                |> DocumenteContractIpoteca.update documenteContractIpotecaMsg
                |> (\v -> Model { model | documenteContractIpoteca = Just v })


toggleDocumenteContractIpoteca : Model -> CheckboxField.Model -> Model
toggleDocumenteContractIpoteca (Model model) newCheckboxFieldModel =
    Model
        { model
            | ui = (\ui -> { ui | hasDocumenteContractIpoteca = newCheckboxFieldModel }) model.ui
            , documenteContractIpoteca =
                if CheckboxField.isChecked newCheckboxFieldModel then
                    Just DocumenteContractIpoteca.initialModel
                else
                    Nothing
        }


view : Model -> Html Msg
view (Model model) =
    fieldset []
        [ DateField.view "Data depunerii:" model.dataDepunere |> map SetDataDepunere
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
templateCerere (Model model) =
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
