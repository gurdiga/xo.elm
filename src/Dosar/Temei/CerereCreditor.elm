module Dosar.Temei.CerereCreditor exposing (Model, initialModel, view, Msg, update)

import Html exposing (Html, h1, fieldset, legend, div, ul, li, text)
import Html.Attributes exposing (style)
import Dosar.Temei.CerereCreditor.Css as Css
import Dosar.Persoana as Persoana


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
    = UpdateDataDepunere MyDate.Msg
    | UpdateCreditor Persoana.Msg


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        UpdateDataDepunere myDateMsg ->
            Model { model | dataDepunere = MyDate.update myDateMsg model.dataDepunere }

        UpdateCreditor persoanaMsg ->
            Model { model | creditor = Persoana.update persoanaMsg model.creditor }


view : Model -> Html Msg
view (Model model) =
    fieldset [ style Css.fieldset ]
        [ MyDate.view "Data depunerii:" model.dataDepunere |> Html.map UpdateDataDepunere
        , Persoana.view model.creditor |> Html.map UpdateCreditor

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
