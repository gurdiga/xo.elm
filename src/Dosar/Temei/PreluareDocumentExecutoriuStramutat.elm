module Dosar.Temei.PreluareDocumentExecutoriuStramutat exposing (Model, Msg, initialModel, update, view)

-- import Utils.RichTextEditor as RichTextEditor

import Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActeEfectuateAnterior as ActeEfectuateAnterior exposing (ActeEfectuateAnterior)
import Dosar.Temei.PreluareDocumentExecutoriuStramutat.CauzaStramutare as CauzaStramutare exposing (CauzaStramutare)
import Html.Styled exposing (Html, button, fieldset, h1, legend, li, map, p, text, ul)
import Utils.DocumentScanat as DocumentScanat exposing (DocumentScanat)


-- import Widgets.Fields exposing (largeTextField)


type Msg
    = Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        Msg ->
            model


type Model
    = Model
        { cauzaStramutare : CauzaStramutare
        , copieIncheiereStramutare : DocumentScanat
        , acteEfectuatAnterior : ActeEfectuateAnterior
        , note : String
        , actPreluare : String
        }


initialModel : Model
initialModel =
    Model
        { cauzaStramutare = CauzaStramutare.empty
        , copieIncheiereStramutare = DocumentScanat.empty
        , acteEfectuatAnterior = ActeEfectuateAnterior.empty
        , note = ""
        , actPreluare = ""
        }


view : Model -> Html Msg
view (Model model) =
    fieldset []
        [ legend [] [ text "PreluareDocumentExecutoriuStramutat" ]

        -- , ul []
        --     [ li [] [ CauzaStramutare.view model.cauzaStramutare (\v -> c { model | cauzaStramutare = v }) ]
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
        -- ]
        ]


templateActPreluare : Model -> List (Html msg)
templateActPreluare (Model model) =
    [ h1 [] [ text "ActPreluare" ]
    , p [] [ model |> toString |> text ]
    ]
