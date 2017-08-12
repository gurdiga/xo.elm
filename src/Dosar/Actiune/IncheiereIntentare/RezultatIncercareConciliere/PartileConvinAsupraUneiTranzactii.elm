module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileConvinAsupraUneiTranzactii
    exposing
        ( PartileConvinAsupraUneiTranzactii
        , newValue
        , view
        )

import Html exposing (Html, h1, div, p, text)
import DocumentScanat exposing (DocumentScanat)
import RichTextEditor


type PartileConvinAsupraUneiTranzactii
    = PartileConvinAsupraUneiTranzactii Data


type alias Data =
    { procesVerbal : String
    , copieSemnataProcesVerbal : DocumentScanat
    }


newValue : PartileConvinAsupraUneiTranzactii
newValue =
    PartileConvinAsupraUneiTranzactii
        { procesVerbal = ""
        , copieSemnataProcesVerbal = DocumentScanat.newValue
        }


view : PartileConvinAsupraUneiTranzactii -> (PartileConvinAsupraUneiTranzactii -> Cmd msg -> Sub msg -> msg) -> Html msg
view ((PartileConvinAsupraUneiTranzactii data) as partileConvinAsupraConditiilorExecutarii) callback =
    let
        c data =
            callback (PartileConvinAsupraUneiTranzactii data) Cmd.none Sub.none
    in
        div []
            [ RichTextEditor.view
                { buttonLabel = "Formează proces-verbal"
                , content = template data
                , onOpen = callback partileConvinAsupraConditiilorExecutarii
                , onResponse = (\s -> c { data | procesVerbal = s })
                }
            , DocumentScanat.view
                { labelText = "Copia scanată a procesului-verbal:"
                , documentScanat = data.copieSemnataProcesVerbal
                , callback = (\v -> c { data | copieSemnataProcesVerbal = v })
                }
            ]


template : Data -> List (Html msg)
template data =
    -- TODO: find the real template
    [ h1 [] [ text "PartileConvinAsupraUneiTranzactii" ]
    , p [] [ text <| toString <| data ]
    ]
