module Dosar.Actiune.IncheiereIntentare exposing (IncheiereIntentare, newValue, view)

import Html exposing (Html, fieldset, legend, div, h1, p, button, text)
import RichTextEditor exposing (TemplateId(TemplateIncheiereIntentare))


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
    fieldset []
        [ legend [] [ text "IncheiereIntentare" ]
        , RichTextEditor.view
            { value = Maybe.withDefault newValue maybeIncheiereIntentare
            , templateId = TemplateIncheiereIntentare
            , compiledTemplate = template TemplateData
            , callback = callback
            , setter = (\(IncheiereIntentare data) s -> IncheiereIntentare { data | generatedHtml = s })
            }
        ]


template : TemplateData -> List (Html msg)
template data =
    [ h1 [] [ text "IncheiereIntentare" ]
    , p [] [ text <| toString <| data ]
    ]


templateId : String
templateId =
    toString TemplateIncheiereIntentare
