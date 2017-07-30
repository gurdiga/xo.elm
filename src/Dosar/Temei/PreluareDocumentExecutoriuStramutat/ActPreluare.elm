module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActPreluare exposing (ActPreluare(ActPreluare), newValue, view)

import Html exposing (Html, fieldset, legend, div, h1, p, button, text)
import RichTextEditor exposing (TemplateId(TemplateActPreluare))


type ActPreluare
    = ActPreluare Data


type alias Data =
    { generatedHtml : String
    , templateData : TemplateData
    }


type TemplateData
    = TemplateData


newValue : ActPreluare
newValue =
    ActPreluare
        { generatedHtml = ""
        , templateData = TemplateData
        }


view : Maybe ActPreluare -> (Maybe ActPreluare -> Cmd msg -> Sub msg -> msg) -> Html msg
view maybeActPreluare callback =
    fieldset []
        [ legend [] [ text "Act de preluare" ]
        , RichTextEditor.view
            { maybeValue = maybeActPreluare
            , newValue = newValue
            , templateId = TemplateActPreluare
            , compiledTemplate = template TemplateData
            , callback = callback
            , valueConstructor = (\(ActPreluare data) s -> ActPreluare { data | generatedHtml = s })
            }
        ]


template : TemplateData -> List (Html msg)
template data =
    [ h1 [] [ text "ActPreluare" ]
    , p [] [ text <| toString <| data ]
    ]


templateId : String
templateId =
    toString TemplateActPreluare
