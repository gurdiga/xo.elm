module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileAjungLaIntelegere.IncheiereIncetare
    exposing
        ( IncheiereIncetare
        , newValue
        , view
        )

import Html exposing (Html, h1, fieldset, legend, p, text)
import RichTextEditor
import DocumentScanat exposing (DocumentScanat)


type IncheiereIncetare
    = IncheiereIncetare Data


type alias Data =
    { html : String
    , copie : DocumentScanat
    }


newValue : IncheiereIncetare
newValue =
    IncheiereIncetare
        { html = ""
        , copie = DocumentScanat.newValue
        }


view : IncheiereIncetare -> (IncheiereIncetare -> Cmd msg -> Sub msg -> msg) -> Html msg
view incheiereIntentare callback =
    let
        (IncheiereIncetare data) =
            incheiereIntentare

        c data =
            callback (IncheiereIncetare data) Cmd.none Sub.none
    in
        fieldset []
            [ legend [] [ text "IncheiereIncetare" ]
            , RichTextEditor.view
                { buttonLabel = "Formează încheiere încetare"
                , content = template data
                , onOpen = callback incheiereIntentare
                , onResponse = (\v -> c { data | html = v })
                }
            , DocumentScanat.view
                { labelText = "Copia încheierii de încetare:"
                , documentScanat = data.copie
                , callback = (\v -> c { data | copie = v })
                }
            ]


template : Data -> List (Html msg)
template data =
    -- TODO: find the real template
    [ h1 [] [ text "IncheiereIncetare" ]
    , p [] [ text <| toString <| data ]
    ]