module Dosar.Temei.CerereCreditor exposing (Model, initialModel, view, Msg, update)

import Html
import Html.Styled exposing (fromUnstyled, Html, h1, fieldset, legend, div, ul, li, text)
import Html.Styled.Attributes exposing (css)
import Dosar.Temei.CerereCreditor.Css as Css
import Dosar.Persoana as Persoana
import Widgets.DateField as DateField


-- import Dosar.Temei.CerereCreditor.DocumenteContractIpoteca as DocumenteContractIpoteca exposing (DocumenteContractIpoteca)
-- import Utils.RichTextEditor as RichTextEditor

import Utils.MyDate as MyDate


type Model
    = Model
        { dataDepunere : MyDate.Model
        , creditor : Persoana.Model
        , html : String

        -- , documenteContractIpoteca : Maybe DocumenteContractIpoteca
        }


initialModel : Model
initialModel =
    Model
        { dataDepunere = MyDate.empty
        , creditor = Persoana.initialModel
        , html = ""

        -- , documenteContractIpoteca = Nothing
        }


type Msg
    = UpdateDataDepunere DateField.Msg
    | UpdateCreditor Persoana.Msg


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        UpdateDataDepunere dateFieldMsg ->
            Model { model | dataDepunere = DateField.update dateFieldMsg model.dataDepunere }

        UpdateCreditor persoanaMsg ->
            Model { model | creditor = Persoana.update persoanaMsg model.creditor }


view : Model -> Html Msg
view (Model model) =
    fieldset [ css [ Css.fieldset ] ]
        [ DateField.view "Data depunerii:" model.dataDepunere |> Html.map UpdateDataDepunere |> fromUnstyled
        , Persoana.view model.creditor |> Html.map UpdateCreditor |> fromUnstyled

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
        -- , DocumenteContractIpoteca.view data.documenteContractIpoteca
        --     (\v -> c { data | documenteContractIpoteca = v })
        ]


templateCerere : Model -> List (Html msg)
templateCerere (Model model) =
    -- TODO: template?
    [ h1 [] [ text "Cerere de intentare" ]
    , model |> toString |> text
    ]
