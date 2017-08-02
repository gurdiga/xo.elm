module Dosar.Actiune.IncheiereRefuz exposing (IncheiereRefuz, newValue, view)

import Dosar.Actiune.IncheiereRefuz.CauzaRefuz as CauzaRefuz exposing (CauzaRefuz)
import Html exposing (Html, fieldset, legend, div, h1, p, button, text)
import RichTextEditor


type IncheiereRefuz
    = IncheiereRefuz Data


type alias Data =
    { cauza : CauzaRefuz
    , generatedHtml : String
    , templateData : TemplateData
    }


type TemplateData
    = TemplateData


newValue : IncheiereRefuz
newValue =
    IncheiereRefuz
        { cauza = CauzaRefuz.newValue
        , generatedHtml = ""
        , templateData = TemplateData
        }


view : Maybe IncheiereRefuz -> (Maybe IncheiereRefuz -> Cmd msg -> Sub msg -> msg) -> Html msg
view maybeIncheiereRefuz callback =
    let
        (IncheiereRefuz data) =
            Maybe.withDefault newValue maybeIncheiereRefuz
    in
        fieldset []
            [ legend [] [ text "IncheiereRefuz" ]
            , RichTextEditor.view
                { buttonLabel = "Editează"
                , content = template TemplateData
                , onOpen = callback maybeIncheiereRefuz
                , onResponse = (\s -> callback (Just (IncheiereRefuz { data | generatedHtml = s })) Cmd.none Sub.none)
                }
            ]


template : TemplateData -> List (Html msg)
template templateData =
    [ h1 [] [ text "IncheiereRefuz" ]
    , p [] [ text <| toString <| templateData ]
    ]
