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
        value =
            Maybe.withDefault newValue maybeIncheiereIntentare

        (IncheiereIntentare data) =
            value
    in
        fieldset []
            [ legend [] [ text "IncheiereIntentare" ]
            , RichTextEditor.view
                { labelText = "Editează"
                , compiledTemplate = template TemplateData
                , onSend = (callback maybeIncheiereIntentare)
                , onReceive = (\s -> callback (Just (IncheiereIntentare { data | generatedHtml = s })) Cmd.none Sub.none)
                }
            ]


template : TemplateData -> List (Html msg)
template data =
    [ h1 [] [ text "IncheiereIntentare" ]
    , p [] [ text <| toString <| data ]
    ]
