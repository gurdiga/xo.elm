module Dosar.Temei.PreluareDocumentExecutoriuStramutat exposing (PreluareDocumentExecutoriuStramutat, newValue, view)

import Html exposing (Html, h1, fieldset, legend, ul, li, p, button, text)
import Dosar.Temei.PreluareDocumentExecutoriuStramutat.CauzaStramutare as CauzaStramutare exposing (CauzaStramutare)
import Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActeEfectuateAnterior as ActeEfectuateAnterior exposing (ActeEfectuateAnterior)
import DocumentScanat exposing (DocumentScanat)
import Widgets.Fields exposing (largeTextField)
import RichTextEditor


type PreluareDocumentExecutoriuStramutat
    = PreluareDocumentExecutoriuStramutat Data


type alias Data =
    { cauzaStramutare : CauzaStramutare
    , copieIncheiereStramutare : DocumentScanat
    , acteEfectuatAnterior : ActeEfectuateAnterior
    , note : String
    , actPreluare : String
    }


newValue : PreluareDocumentExecutoriuStramutat
newValue =
    PreluareDocumentExecutoriuStramutat
        { cauzaStramutare = CauzaStramutare.newValue
        , copieIncheiereStramutare = DocumentScanat.newValue
        , acteEfectuatAnterior = ActeEfectuateAnterior.newValue
        , note = ""
        , actPreluare = ""
        }


view : PreluareDocumentExecutoriuStramutat -> (PreluareDocumentExecutoriuStramutat -> Cmd msg -> Sub msg -> msg) -> Html msg
view preluareDocumentExecutoriuStramutat callback =
    let
        (PreluareDocumentExecutoriuStramutat data) =
            preluareDocumentExecutoriuStramutat

        c data =
            callback (PreluareDocumentExecutoriuStramutat data) Cmd.none Sub.none
    in
        fieldset []
            [ legend [] [ text "PreluareDocumentExecutoriuStramutat" ]
            , ul []
                [ li [] [ CauzaStramutare.view data.cauzaStramutare (\v -> c { data | cauzaStramutare = v }) ]
                , li []
                    [ DocumentScanat.view "Copia încheierii:"
                        data.copieIncheiereStramutare
                        (\v -> c { data | copieIncheiereStramutare = v })
                    ]
                , li [] [ ActeEfectuateAnterior.view data.acteEfectuatAnterior (\v -> c { data | acteEfectuatAnterior = v }) ]
                , li [] [ largeTextField "Note:" data.note (\v -> c { data | note = v }) ]
                , li []
                    [ RichTextEditor.view
                        { buttonLabel = "Formează act preluare"
                        , content = templateActPreluare data
                        , onOpen = callback preluareDocumentExecutoriuStramutat
                        , onResponse = (\s -> c { data | actPreluare = s })
                        }
                    ]
                ]
            ]


templateActPreluare : Data -> List (Html msg)
templateActPreluare data =
    [ h1 [] [ text "ActPreluare" ]
    , p [] [ data |> toString |> text ]
    ]
