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


view : ActPreluare -> (ActPreluare -> Cmd msg -> Sub msg -> msg) -> Html msg
view actPreluare callback =
    let
        (ActPreluare data) =
            actPreluare

        noop =
            callback actPreluare

        c data =
            callback (ActPreluare data) Cmd.none Sub.none
    in
        fieldset []
            [ legend [] [ text "Act de preluare" ]
            , RichTextEditor.view
                { buttonLabel = "Editează"
                , content = template TemplateData -- TODO: get rid of TemplateData
                , onOpen = noop
                , onResponse = (\s -> c { data | generatedHtml = s })
                }
            ]


template : TemplateData -> List (Html msg)
template templateData =
    [ h1 [] [ text "ActPreluare" ]
    , p [] [ text <| toString <| templateData ]
    ]
