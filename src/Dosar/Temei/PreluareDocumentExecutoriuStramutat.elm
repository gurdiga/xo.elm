module Dosar.Temei.PreluareDocumentExecutoriuStramutat exposing (Model, Msg, initialModel, update, view)

-- import Utils.RichTextEditor as RichTextEditor

import Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActeEfectuateAnterior as ActeEfectuateAnterior exposing (ActeEfectuateAnterior)
import Dosar.Temei.PreluareDocumentExecutoriuStramutat.CauzaStramutare as CauzaStramutare
import Dosar.Temei.PreluareDocumentExecutoriuStramutat.DocumentScanat2 as DocumentScanat2
import Html.Styled exposing (Html, fieldset, h1, legend, li, map, p, text, ul)
import Widgets.Select3 as Select3


-- import Widgets.Fields exposing (largeTextField)


type Msg
    = SetCauzaStramutare (Select3.Msg CauzaStramutare.Model)
    | SetCopieIncheiereStramutare DocumentScanat2.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetCauzaStramutare select3Msg ->
            receiveCauzaStramutare model (Select3.update select3Msg model.ui.cauzaStramutareSelect)

        SetCopieIncheiereStramutare documentScanat2Msg ->
            { model | copieIncheiereStramutare = (DocumentScanat2.update documentScanat2Msg model.ui.copieIncheiereStramutare) }


receiveCauzaStramutare : Model -> Select3.Model CauzaStramutare.Model -> Model
receiveCauzaStramutare ({ ui } as model) newSelect =
    { model
        | ui = { ui | cauzaStramutareSelect = newSelect }
        , cauzaStramutare = Select3.selectedValue newSelect
    }


type alias Model =
    { cauzaStramutare : CauzaStramutare.Model
    , copieIncheiereStramutare : DocumentScanat2.Model
    , acteEfectuatAnterior : ActeEfectuateAnterior
    , note : String
    , actPreluare : String
    , ui : Ui
    }


type alias Ui =
    { cauzaStramutareSelect : Select3.Model CauzaStramutare.Model
    , copieIncheiereStramutare : DocumentScanat2.Model
    }


initialModel : Model
initialModel =
    { cauzaStramutare = CauzaStramutare.initialModel
    , copieIncheiereStramutare = DocumentScanat2.initialModel
    , acteEfectuatAnterior = ActeEfectuateAnterior.empty
    , note = ""
    , actPreluare = ""
    , ui =
        { cauzaStramutareSelect = Select3.initialModel CauzaStramutare.initialModel CauzaStramutare.valuesWithLabels
        , copieIncheiereStramutare = DocumentScanat2.initialModel
        }
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "PreluareDocumentExecutoriuStramutat" ]
        , ul []
            [ li [] [ Select3.view "Cauza strămutării:" model.ui.cauzaStramutareSelect |> map SetCauzaStramutare ]
            , li [] [ DocumentScanat2.view "Copia încheierii:" model.copieIncheiereStramutare |> map SetCopieIncheiereStramutare ]

            --
            --     TODO: Continue here. Can I TDD this?
            --
            --     , li [] [ ActeEfectuateAnterior.view model.acteEfectuatAnterior (\v -> c { model | acteEfectuatAnterior = v }) ]
            --     , li [] [ largeTextField "Note:" model.note (\v -> c { model | note = v }) ]
            --     , li []
            --         [ RichTextEditor.view
            --             { buttonLabel = "Formează act preluare"
            --             , content = templateActPreluare (Model model)
            --             , onOpen = callback preluareDocumentExecutoriuStramutat
            --             , onResponse = \s -> c { model | actPreluare = s }
            --             }
            --         ]
            ]
        ]


templateActPreluare : Model -> List (Html msg)
templateActPreluare model =
    [ h1 [] [ text "ActPreluare" ]
    , p [] [ model |> toString |> text ]
    ]
