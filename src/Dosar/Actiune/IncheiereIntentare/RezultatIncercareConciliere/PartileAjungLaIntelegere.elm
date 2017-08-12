module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileAjungLaIntelegere
    exposing
        ( PartileAjungLaIntelegere
        , newValue
        , view
        )

import Html exposing (Html, h1, div, p, text)
import RichTextEditor
import DocumentScanat exposing (DocumentScanat)


type PartileAjungLaIntelegere
    = PartileAjungLaIntelegere Data


type alias Data =
    { procesVerbalConditiiExecutare : String
    , copieProcesVerbalConditiiExecutare : DocumentScanat
    }


newValue : PartileAjungLaIntelegere
newValue =
    PartileAjungLaIntelegere
        { procesVerbalConditiiExecutare = ""
        , copieProcesVerbalConditiiExecutare = DocumentScanat.newValue
        }


view : PartileAjungLaIntelegere -> (PartileAjungLaIntelegere -> Cmd msg -> Sub msg -> msg) -> Html msg
view partileAjungLaIntelegere callback =
    let
        (PartileAjungLaIntelegere data) =
            partileAjungLaIntelegere

        c data =
            callback (PartileAjungLaIntelegere data) Cmd.none Sub.none
    in
        div []
            [ RichTextEditor.view
                { buttonLabel = "Formează proces-verbal conditii executare"
                , content = template data
                , onOpen = callback partileAjungLaIntelegere
                , onResponse = (\s -> c { data | procesVerbalConditiiExecutare = s })
                }
            , DocumentScanat.view
                { labelText = "Copia semnată a procesului-verbal condiții executare"
                , documentScanat = data.copieProcesVerbalConditiiExecutare
                , callback = (\v -> c { data | copieProcesVerbalConditiiExecutare = v })
                }
            ]


template : Data -> List (Html msg)
template data =
    -- TODO: find the real template
    [ h1 [] [ text "Proces-verbal PartileAjungLaIntelegere" ]
    , p [] [ text <| toString <| data ]
    ]
