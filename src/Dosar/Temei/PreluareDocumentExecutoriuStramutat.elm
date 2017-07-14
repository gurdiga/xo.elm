module Dosar.Temei.PreluareDocumentExecutoriuStramutat exposing (PreluareDocumentExecutoriuStramutat, newValue, view)

import Html exposing (Html, fieldset, legend, ul, li, button, text)
import Dosar.Temei.PreluareDocumentExecutoriuStramutat.CauzaStramutare as CauzaStramutare exposing (CauzaStramutare)
import Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActeEfectuateAnterior as ActeEfectuateAnterior exposing (ActeEfectuateAnterior)
import Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActPreluare as ActPreluare exposing (ActPreluare(ActPreluare))
import DocumentScanat exposing (DocumentScanat)
import Widgets.Fields exposing (largeTextField)


type PreluareDocumentExecutoriuStramutat
    = PreluareDocumentExecutoriuStramutat
        { cauzaStramutare : CauzaStramutare
        , copieIncheiereStramutare : DocumentScanat
        , acteEfectuatAnterior : ActeEfectuateAnterior
        , note : String
        , actPreluare : Maybe ActPreluare
        }


newValue : PreluareDocumentExecutoriuStramutat
newValue =
    PreluareDocumentExecutoriuStramutat
        { cauzaStramutare = CauzaStramutare.newValue
        , copieIncheiereStramutare = DocumentScanat.newValue
        , acteEfectuatAnterior = ActeEfectuateAnterior.newValue
        , note = ""
        , actPreluare = Nothing
        }


view : PreluareDocumentExecutoriuStramutat -> (PreluareDocumentExecutoriuStramutat -> msg) -> Html msg
view (PreluareDocumentExecutoriuStramutat data) callback =
    let
        c =
            callback << PreluareDocumentExecutoriuStramutat
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
                , li [] [ ActPreluare.view data.actPreluare (\v -> c { data | actPreluare = v }) ]
                ]
            ]
