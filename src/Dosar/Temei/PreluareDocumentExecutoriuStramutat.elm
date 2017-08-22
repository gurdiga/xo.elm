module Dosar.Temei.PreluareDocumentExecutoriuStramutat exposing (PreluareDocumentExecutoriuStramutat, empty, view)

import Html exposing (Html, h1, fieldset, legend, ul, li, p, button, text)
import Dosar.Temei.PreluareDocumentExecutoriuStramutat.CauzaStramutare as CauzaStramutare exposing (CauzaStramutare)
import Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActeEfectuateAnterior as ActeEfectuateAnterior exposing (ActeEfectuateAnterior)
import Utils.DocumentScanat as DocumentScanat exposing (DocumentScanat)
import Widgets.Fields exposing (largeTextField)
import Utils.RichTextEditor as RichTextEditor


type PreluareDocumentExecutoriuStramutat
    = PreluareDocumentExecutoriuStramutat Data


type alias Data =
    { cauzaStramutare : CauzaStramutare
    , copieIncheiereStramutare : DocumentScanat
    , acteEfectuatAnterior : ActeEfectuateAnterior
    , note : String
    , actPreluare : String
    }


empty : PreluareDocumentExecutoriuStramutat
empty =
    PreluareDocumentExecutoriuStramutat
        { cauzaStramutare = CauzaStramutare.empty
        , copieIncheiereStramutare = DocumentScanat.empty
        , acteEfectuatAnterior = ActeEfectuateAnterior.empty
        , note = ""
        , actPreluare = ""
        }


view : PreluareDocumentExecutoriuStramutat -> (PreluareDocumentExecutoriuStramutat -> Cmd msg -> Sub msg -> msg) -> Html msg
view ((PreluareDocumentExecutoriuStramutat data) as preluareDocumentExecutoriuStramutat) callback =
    let
        c data =
            callback (PreluareDocumentExecutoriuStramutat data) Cmd.none Sub.none
    in
        fieldset []
            [ legend [] [ text "PreluareDocumentExecutoriuStramutat" ]
            , ul []
                [ li [] [ CauzaStramutare.view data.cauzaStramutare (\v -> c { data | cauzaStramutare = v }) ]
                , li []
                    [ DocumentScanat.view
                        { labelText = "Copia încheierii:"
                        , documentScanat = data.copieIncheiereStramutare
                        , callback = (\v -> c { data | copieIncheiereStramutare = v })
                        }
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
