module Dosar.Temei.PreluareDocumentExecutoriuStramutat exposing (PreluareDocumentExecutoriuStramutat, newValue, view)

import Html exposing (Html, fieldset, legend, ul, li, text)
import Dosar.Temei.PreluareDocumentExecutoriuStramutat.IncheiereStramutare as IncheiereStramutare exposing (IncheiereStramutare)
import Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActeEfectuateAnterior as ActeEfectuateAnterior exposing (ActeEfectuateAnterior)
import DocumentScanat exposing (DocumentScanat)
import Widgets.Fields exposing (largeTextField)


type PreluareDocumentExecutoriuStramutat
    = PreluareDocumentExecutoriuStramutat
        { incheiereStramutare : IncheiereStramutare
        , copieIncheiereStramutare : DocumentScanat
        , acteEfectuatAnterior : ActeEfectuateAnterior
        , note : String
        }


newValue : PreluareDocumentExecutoriuStramutat
newValue =
    PreluareDocumentExecutoriuStramutat
        { incheiereStramutare = IncheiereStramutare.newValue
        , copieIncheiereStramutare = DocumentScanat.newValue
        , acteEfectuatAnterior = ActeEfectuateAnterior.newValue
        , note = ""
        }


view : PreluareDocumentExecutoriuStramutat -> (PreluareDocumentExecutoriuStramutat -> msg) -> Html msg
view (PreluareDocumentExecutoriuStramutat data) callback =
    fieldset []
        [ legend [] [ text "PreluareDocumentExecutoriuStramutat" ]
        , ul []
            [ li []
                [ IncheiereStramutare.view data.incheiereStramutare
                    (\v -> callback (PreluareDocumentExecutoriuStramutat { data | incheiereStramutare = v }))
                ]
            , li []
                [ DocumentScanat.view "Copia încheierii:"
                    data.copieIncheiereStramutare
                    (\v -> callback (PreluareDocumentExecutoriuStramutat { data | copieIncheiereStramutare = v }))
                ]
            , li []
                [ ActeEfectuateAnterior.view data.acteEfectuatAnterior
                    (\v -> callback (PreluareDocumentExecutoriuStramutat { data | acteEfectuatAnterior = v }))
                ]
            , li []
                [ largeTextField "Note:"
                    data.note
                    (\v -> callback (PreluareDocumentExecutoriuStramutat { data | note = v }))
                ]
            ]
        ]
