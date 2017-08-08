module Dosar.Actiune.IncheiereIntentare exposing (IncheiereIntentare, newValue, view)

import Html exposing (Html, fieldset, legend, div, h1, p, button, text)
import RichTextEditor
import DocumentScanat exposing (DocumentScanat)
import Widgets.Fields exposing (dateField)
import MyDate exposing (MyDate)


type IncheiereIntentare
    = IncheiereIntentare Data


type alias Data =
    { html : String
    , borderouDeCalcul : String
    , copieIncheiere : DocumentScanat
    , termenConciliere : MyDate
    }


newValue : IncheiereIntentare
newValue =
    IncheiereIntentare
        { html = ""
        , borderouDeCalcul = ""
        , copieIncheiere = DocumentScanat.newValue
        , termenConciliere = MyDate.newValue
        }


view : IncheiereIntentare -> (IncheiereIntentare -> Cmd msg -> Sub msg -> msg) -> Html msg
view incheiereIntentare callback =
    let
        (IncheiereIntentare data) =
            incheiereIntentare

        c data =
            callback (IncheiereIntentare data) Cmd.none Sub.none
    in
        fieldset []
            [ legend [] [ text "IncheiereIntentare" ]
            , RichTextEditor.view
                { buttonLabel = "Editează"
                , content = template data
                , onOpen = callback incheiereIntentare
                , onResponse = (\s -> c { data | html = s })
                }
            , RichTextEditor.view
                { buttonLabel = "Formează borderou de calcul"
                , content = borderouDeCalculTemplate data
                , onOpen = callback incheiereIntentare
                , onResponse = (\s -> c { data | borderouDeCalcul = s })
                }
            , DocumentScanat.view
                { labelText = "Copia încheierii:"
                , documentScanat = data.copieIncheiere
                , callback = (\v -> c { data | copieIncheiere = v })
                }
            , dateField "Termen de conciliere:" data.termenConciliere (\v -> c { data | termenConciliere = v })
            ]


template : Data -> List (Html msg)
template data =
    -- TODO: find the real template
    [ h1 [] [ text "IncheiereIntentare" ]
    , p [] [ text <| toString <| data ]
    ]


borderouDeCalculTemplate : Data -> List (Html msg)
borderouDeCalculTemplate data =
    -- TODO: find the real template
    [ h1 [] [ text "Borderou de calcul pentru cheltuielile de intentare" ]
    , p [] [ text <| toString <| data ]
    ]
