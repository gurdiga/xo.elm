module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActPreluare exposing (ActPreluare(ActPreluare), newValue, view)

import Html exposing (Html, fieldset, legend, div, h1, p, button, text)
import RichTextEditor


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
    let
        (ActPreluare data) =
            Maybe.withDefault newValue maybeActPreluare
    in
        fieldset []
            [ legend [] [ text "Act de preluare" ]
            , RichTextEditor.view
                { buttonLabel = "Editează"
                , content = template TemplateData
                , onEdit = (callback maybeActPreluare)
                , onReceive = (\s -> callback (Just (ActPreluare { data | generatedHtml = s })) Cmd.none Sub.none)
                }
            ]


template : TemplateData -> List (Html msg)
template templateData =
    [ h1 [] [ text "ActPreluare" ]
    , p [] [ text <| toString <| templateData ]
    ]
