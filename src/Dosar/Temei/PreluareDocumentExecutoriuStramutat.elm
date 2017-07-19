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


view : PreluareDocumentExecutoriuStramutat -> (PreluareDocumentExecutoriuStramutat -> Sub msg -> Cmd msg -> msg) -> Html msg
view (PreluareDocumentExecutoriuStramutat data) c =
    let
        callback =
            (\v -> c v Sub.none Cmd.none) << PreluareDocumentExecutoriuStramutat
    in
        fieldset []
            [ legend [] [ text "PreluareDocumentExecutoriuStramutat" ]
            , ul []
                [ li [] [ CauzaStramutare.view data.cauzaStramutare (\v -> callback { data | cauzaStramutare = v }) ]
                , li []
                    [ DocumentScanat.view "Copia încheierii:"
                        data.copieIncheiereStramutare
                        (\v -> callback { data | copieIncheiereStramutare = v })
                    ]
                , li [] [ ActeEfectuateAnterior.view data.acteEfectuatAnterior (\v -> callback { data | acteEfectuatAnterior = v }) ]
                , li [] [ largeTextField "Note:" data.note (\v -> callback { data | note = v }) ]
                , li [] [ ActPreluare.view data.actPreluare (\v -> c (PreluareDocumentExecutoriuStramutat { data | actPreluare = v })) ]
                ]
            ]
