module Dosar.Temei.CerereCreditor exposing (Model, Msg, initialModel, update, view)

-- import Utils.RichTextEditor as RichTextEditor

import Dosar.Persoana as Persoana
import Dosar.Temei.CerereCreditor.Css as Css
import Dosar.Temei.CerereCreditor.DocumenteContractIpoteca as DocumenteContractIpoteca
import Html.Styled exposing (Html, div, fieldset, fromUnstyled, h1, legend, li, map, text, ul)
import Html.Styled.Attributes exposing (css)
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
        , documenteContractIpoteca = Nothing
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
            CheckboxField.update checkboxFieldMsg model.ui.hasDocumenteContractIpoteca
                |> toggleDocumenteContractIpoteca (Model model)

        SetDocumenteContractIpoteca documenteContractIpotecaMsg ->
            -- TODO: Figure this out
            Model model


toggleDocumenteContractIpoteca : Model -> CheckboxField.Model -> Model
toggleDocumenteContractIpoteca (Model model) newCheckboxFieldModel =
    Model
        { model
            | ui = setUiHasDocumenteContractIpoteca model.ui newCheckboxFieldModel
            , documenteContractIpoteca =
                if CheckboxField.isChecked newCheckboxFieldModel then
                    Just DocumenteContractIpoteca.initialModel
                else
                    Nothing
        }


setUiHasDocumenteContractIpoteca : Ui -> CheckboxField.Model -> Ui
setUiHasDocumenteContractIpoteca ui checkboxFieldModel =
    { ui | hasDocumenteContractIpoteca = checkboxFieldModel }


view : Model -> Html Msg
view (Model model) =
    fieldset [ css [ Css.fieldset ] ]
        [ DateField.view "Data depunerii:" model.dataDepunere |> map SetDataDepunere
        , Persoana.view model.creditor |> map SetCreditor
        , documenteContractIpotecaView model.documenteContractIpoteca

        --
        -- TODO: continue here:
        --
        --
        -- , RichTextEditor.view
        --     { buttonLabel = "Formează cerere" -- TODO: make it printable
        --     , content = templateCerere data
        --     , onOpen = callback cerereCreditor
        --     , onResponse = (\s -> c { data | html = s })
        --     }
        --     (\v -> c { data | documenteContractIpoteca = v })
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
    , model |> toString |> text
    ]


maybeToBool : Maybe a -> Bool
maybeToBool maybeA =
    case maybeA of
        Just a ->
            True

        Nothing ->
            False
