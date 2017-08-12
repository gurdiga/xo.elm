module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileConvinAsupraConditiilorExecutarii
    exposing
        ( PartileConvinAsupraConditiilorExecutarii
        , newValue
        , view
        )

import Html exposing (Html, h1, div, p, text)
import DocumentScanat exposing (DocumentScanat)
import RichTextEditor


type PartileConvinAsupraConditiilorExecutarii
    = PartileConvinAsupraConditiilorExecutarii Data


type alias Data =
    { procesVerbal : String
    , copieSemnataProcesVerbal : DocumentScanat
    }


newValue : PartileConvinAsupraConditiilorExecutarii
newValue =
    PartileConvinAsupraConditiilorExecutarii
        { procesVerbal = ""
        , copieSemnataProcesVerbal = DocumentScanat.newValue
        }


view : PartileConvinAsupraConditiilorExecutarii -> (PartileConvinAsupraConditiilorExecutarii -> Cmd msg -> Sub msg -> msg) -> Html msg
view ((PartileConvinAsupraConditiilorExecutarii data) as partileConvinAsupraConditiilorExecutarii) callback =
    let
        c data =
            callback (PartileConvinAsupraConditiilorExecutarii data) Cmd.none Sub.none
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
    [ h1 [] [ text "PartileConvinAsupraConditiilorExecutarii" ]
    , p [] [ text <| toString <| data ]
    ]
