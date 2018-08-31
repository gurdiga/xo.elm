module Dosar.Temei.PreluareDocumentExecutoriuStramutat exposing (Model, Msg, initialModel, update, view)

-- import Utils.RichTextEditor as RichTextEditor

import Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActeEfectuateAnterior as ActeEfectuateAnterior
import Dosar.Temei.PreluareDocumentExecutoriuStramutat.CauzaStramutare as CauzaStramutare
import Dosar.Temei.PreluareDocumentExecutoriuStramutat.DocumentScanat2 as DocumentScanat2
import Html exposing (Html, fieldset, h1, legend, li, map, p, text, ul)
import Widgets.Select4 as Select4


-- import Widgets.Fields exposing (largeTextField)


type Msg
    = SetCauzaStramutare CauzaStramutare.Model
    | SetCopieIncheiereStramutare DocumentScanat2.Msg
    | SetActeEfectuatAnterior ActeEfectuateAnterior.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetCauzaStramutare v ->
            { model | cauzaStramutare = v }

        SetCopieIncheiereStramutare documentScanat2Msg ->
            { model | copieIncheiereStramutare = DocumentScanat2.update documentScanat2Msg model.ui.copieIncheiereStramutare }

        SetActeEfectuatAnterior acteEfectuateAnteriorMsg ->
            { model | acteEfectuateAnterior = ActeEfectuateAnterior.update acteEfectuateAnteriorMsg model.acteEfectuateAnterior }


type alias Model =
    { cauzaStramutare : CauzaStramutare.Model
    , copieIncheiereStramutare : DocumentScanat2.Model
    , acteEfectuateAnterior : ActeEfectuateAnterior.Model
    , note : String
    , actPreluare : String
    , ui : Ui
    }


type alias Ui =
    { copieIncheiereStramutare : DocumentScanat2.Model
    }


initialModel : Model
initialModel =
    { cauzaStramutare = CauzaStramutare.initialModel
    , copieIncheiereStramutare = DocumentScanat2.initialModel
    , acteEfectuateAnterior = ActeEfectuateAnterior.initialModel
    , note = ""
    , actPreluare = ""
    , ui =
        { copieIncheiereStramutare = DocumentScanat2.initialModel
        }
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "PreluareDocumentExecutoriuStramutat" ]
        , ul []
            [ li []
                [ Select4.view <|
                    Select4.config
                        { label = "Cauza strămutării:"
                        , valuesWithLabels = CauzaStramutare.valuesWithLabels
                        , defaultValue = model.cauzaStramutare
                        , onInput = SetCauzaStramutare
                        }
                ]
            , li [] [ DocumentScanat2.view "Copia încheierii:" model.copieIncheiereStramutare |> map SetCopieIncheiereStramutare ]
            , li [] [ ActeEfectuateAnterior.view model.acteEfectuateAnterior |> map SetActeEfectuatAnterior ]

            --
            --     TODO: Continue here. Can I TDD this?
            --
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
    , p [] [ text "TODO" ]
    ]
