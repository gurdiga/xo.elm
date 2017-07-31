module Dosar.Actiune.IncheiereIntentare exposing (IncheiereIntentare, newValue, view)

import Html exposing (Html, fieldset, legend, div, h1, p, button, text)
import RichTextEditor


type IncheiereIntentare
    = IncheiereIntentare Data


type alias Data =
    { generatedHtml : String
    , templateData : TemplateData
    }


type TemplateData
    = TemplateData


newValue : IncheiereIntentare
newValue =
    IncheiereIntentare
        { generatedHtml = ""
        , templateData = TemplateData
        }


view : Maybe IncheiereIntentare -> (Maybe IncheiereIntentare -> Cmd msg -> Sub msg -> msg) -> Html msg
view maybeIncheiereIntentare callback =
    let
        (IncheiereIntentare data) =
            Maybe.withDefault newValue maybeIncheiereIntentare
    in
        fieldset []
            [ legend [] [ text "IncheiereIntentare" ]
            , RichTextEditor.view
                { buttonLabel = "Editează"
                , content = template TemplateData
                , onOpen = callback maybeIncheiereIntentare
                , onResponse = (\s -> callback (Just (IncheiereIntentare { data | generatedHtml = s })) Cmd.none Sub.none)
                }
            ]


template : TemplateData -> List (Html msg)
template templateData =
    [ h1 [] [ text "IncheiereIntentare" ]
    , p [] [ text <| toString <| templateData ]
    ]
