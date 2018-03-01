module Dosar.Temei.PreluareDocumentExecutoriuStramutat exposing (Model, Msg, initialModel, update, view)

-- import Utils.RichTextEditor as RichTextEditor

import Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActeEfectuateAnterior as ActeEfectuateAnterior exposing (ActeEfectuateAnterior)
import Dosar.Temei.PreluareDocumentExecutoriuStramutat.CauzaStramutare as CauzaStramutare
import Html.Styled exposing (Html, button, fieldset, h1, legend, li, map, p, text, ul)
import Utils.DocumentScanat as DocumentScanat exposing (DocumentScanat)
import Widgets.Select3 as Select3


-- import Widgets.Fields exposing (largeTextField)


type Msg
    = SetCauzaStramutare (Select3.Msg CauzaStramutare.Model)


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        SetCauzaStramutare select3Msg ->
            receiveCauzaStramutare (Model model) (Select3.update select3Msg model.ui.cauzaStramutareSelect)


receiveCauzaStramutare : Model -> Select3.Model CauzaStramutare.Model -> Model
receiveCauzaStramutare (Model ({ ui } as model)) newSelect =
    Model
        { model
            | ui = { ui | cauzaStramutareSelect = newSelect }
            , cauzaStramutare = Select3.selectedValue newSelect
        }


type Model
    = Model
        { cauzaStramutare : CauzaStramutare.Model
        , copieIncheiereStramutare : DocumentScanat
        , acteEfectuatAnterior : ActeEfectuateAnterior
        , note : String
        , actPreluare : String
        , ui : Ui
        }


type alias Ui =
    { cauzaStramutareSelect : Select3.Model CauzaStramutare.Model
    }


initialModel : Model
initialModel =
    Model
        { cauzaStramutare = CauzaStramutare.initialModel
        , copieIncheiereStramutare = DocumentScanat.empty
        , acteEfectuatAnterior = ActeEfectuateAnterior.empty
        , note = ""
        , actPreluare = ""
        , ui =
            { cauzaStramutareSelect = Select3.initialModel CauzaStramutare.initialModel CauzaStramutare.valuesWithLabels
            }
        }


view : Model -> Html Msg
view (Model model) =
    fieldset []
        [ legend [] [ text "PreluareDocumentExecutoriuStramutat" ]
        , ul []
            [ li [] [ Select3.view "Cauza strămutării:" model.ui.cauzaStramutareSelect |> map SetCauzaStramutare ]

            --     , li []
            --         [ DocumentScanat.view
            --             { labelText = "Copia încheierii:"
            --             , documentScanat = model.copieIncheiereStramutare
            --             , callback = \v -> c { model | copieIncheiereStramutare = v }
            --             }
            --         ]
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
templateActPreluare (Model model) =
    [ h1 [] [ text "ActPreluare" ]
    , p [] [ model |> toString |> text ]
    ]
