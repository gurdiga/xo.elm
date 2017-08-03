module Dosar.Actiune.IncheiereIntentare exposing (IncheiereIntentare, newValue, view)

import Html exposing (Html, fieldset, legend, div, h1, p, button, text)
import RichTextEditor


type IncheiereIntentare
    = IncheiereIntentare Data


type alias Data =
    { html : String
    }


newValue : IncheiereIntentare
newValue =
    IncheiereIntentare
        { html = ""
        }


view : IncheiereIntentare -> (IncheiereIntentare -> Cmd msg -> Sub msg -> msg) -> Html msg
view incheiereIntentare callback =
    let
        (IncheiereIntentare data) =
            incheiereIntentare
    in
        fieldset []
            [ legend [] [ text "IncheiereIntentare" ]
            , RichTextEditor.view
                { buttonLabel = "Editează"
                , content = template data
                , onOpen = callback incheiereIntentare
                , onResponse = (\s -> callback (IncheiereIntentare { data | html = s }) Cmd.none Sub.none)
                }
            ]


template : Data -> List (Html msg)
template data =
    -- TODO: find the real template
    [ h1 [] [ text "IncheiereIntentare" ]
    , p [] [ text <| toString <| data ]
    ]
