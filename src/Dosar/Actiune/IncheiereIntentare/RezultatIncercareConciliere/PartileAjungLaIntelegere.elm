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
    { procesVerbalConsemnareConditiiExecutare : String
    , copieProcesVerbalConsemnareConditiiExecutare : DocumentScanat
    , procesVerbalConstatareExecutare : String
    , copieProcesVerbalConstatareExecutare : DocumentScanat
    }


newValue : PartileAjungLaIntelegere
newValue =
    PartileAjungLaIntelegere
        { procesVerbalConsemnareConditiiExecutare = ""
        , copieProcesVerbalConsemnareConditiiExecutare = DocumentScanat.newValue
        , procesVerbalConstatareExecutare = ""
        , copieProcesVerbalConstatareExecutare = DocumentScanat.newValue
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
                { buttonLabel = "Formează proces-verbal de consemnare condițiilor de executare"
                , content = templateProcesVerbalConsemnareConditiiExecutare data
                , onOpen = callback partileAjungLaIntelegere
                , onResponse = (\v -> c { data | procesVerbalConsemnareConditiiExecutare = v })
                }
            , DocumentScanat.view
                { labelText = "Copia semnată a procesului-verbal de consemnare a condițiilor de executare"
                , documentScanat = data.copieProcesVerbalConsemnareConditiiExecutare
                , callback = (\v -> c { data | copieProcesVerbalConsemnareConditiiExecutare = v })
                }
            , RichTextEditor.view
                { buttonLabel = "Formează proces-verbal de constatare a executării"
                , content = templateProcesVerbalConstatareExecutare data
                , onOpen = callback partileAjungLaIntelegere
                , onResponse = (\v -> c { data | procesVerbalConstatareExecutare = v })
                }
            , DocumentScanat.view
                { labelText = "Copia semnată a procesului-verbal de constatare a executării"
                , documentScanat = data.copieProcesVerbalConstatareExecutare
                , callback = (\v -> c { data | copieProcesVerbalConstatareExecutare = v })
                }
            ]


templateProcesVerbalConsemnareConditiiExecutare : Data -> List (Html msg)
templateProcesVerbalConsemnareConditiiExecutare data =
    -- TODO: find the real template
    [ h1 [] [ text "Proces-verbal de consemnare a condițiilor de executare" ]
    , p [] [ text <| toString <| data ]
    ]


templateProcesVerbalConstatareExecutare : Data -> List (Html msg)
templateProcesVerbalConstatareExecutare data =
    -- TODO: find the real template
    [ h1 [] [ text "Proces-verbal de constatare a executării" ]
    , p [] [ text <| toString <| data ]
    ]
