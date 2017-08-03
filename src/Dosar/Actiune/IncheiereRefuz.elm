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

        c data =
            callback (Just (IncheiereRefuz data)) Cmd.none Sub.none
    in
        fieldset []
            [ legend [] [ text "IncheiereRefuz" ]
            , CauzaRefuz.view data.cauza (\v -> c { data | cauza = v })
            , RichTextEditor.view
                { buttonLabel = "Editează"
                , content = template TemplateData
                , onOpen = callback maybeIncheiereRefuz
                , onResponse = (\s -> c { data | generatedHtml = s })
                }
            ]


template : TemplateData -> List (Html msg)
template templateData =
    [ h1 [] [ text "IncheiereRefuz" ]
    , p [] [ text <| toString <| templateData ]
    ]
