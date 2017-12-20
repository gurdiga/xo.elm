module Dosar.Temei.CerereCreditor exposing (Model, empty, view, Msg, update)

import Html exposing (Html, h1, fieldset, legend, div, ul, li, text)
import Html.Attributes exposing (style)
import Dosar.Temei.CerereCreditor.Css as Css


-- import Dosar.Persoana as Persoana exposing (Persoana)
-- import Dosar.Temei.CerereCreditor.DocumenteContractIpoteca as DocumenteContractIpoteca exposing (DocumenteContractIpoteca)
-- import Utils.RichTextEditor as RichTextEditor

import Utils.MyDate as MyDate


type Model
    = Model
        { dataDepunere : MyDate.Model

        -- , creditor : Persoana
        , html : String

        -- , documenteContractIpoteca : Maybe DocumenteContractIpoteca
        }


empty : Model
empty =
    Model
        { dataDepunere = MyDate.empty

        -- , creditor = Persoana.empty
        , html = ""

        -- , documenteContractIpoteca = Nothing
        }


type Msg
    = MyDateMsg MyDate.Msg


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        MyDateMsg myDateMsg ->
            Model { model | dataDepunere = MyDate.update myDateMsg model.dataDepunere }


view : Model -> Html Msg
view ((Model data) as model) =
    fieldset [ style Css.fieldset ]
        [ MyDate.view "Data depunerii:" data.dataDepunere |> Html.map MyDateMsg

        --
        -- TODO: continue here:
        --
        --
        -- , Persoana.view data.creditor (\v -> c { data | creditor = v })
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
