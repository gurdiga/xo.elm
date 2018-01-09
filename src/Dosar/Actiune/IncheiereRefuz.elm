module Dosar.Actiune.IncheiereRefuz exposing (IncheiereRefuz, empty, view)

import Dosar.Actiune.IncheiereRefuz.CauzaRefuz as CauzaRefuz exposing (CauzaRefuz)
import Html exposing (Html, button, div, fieldset, h1, legend, p, text)
import Utils.RichTextEditor as RichTextEditor


type IncheiereRefuz
    = IncheiereRefuz Data


type alias Data =
    { cauza : CauzaRefuz
    , html : String
    }


empty : IncheiereRefuz
empty =
    IncheiereRefuz
        { cauza = CauzaRefuz.empty
        , html = ""
        }


view : IncheiereRefuz -> (IncheiereRefuz -> Cmd msg -> Sub msg -> msg) -> Html msg
view ((IncheiereRefuz data) as incheiereRefuz) callback =
    let
        c data =
            callback (IncheiereRefuz data) Cmd.none Sub.none
    in
    fieldset []
        [ legend [] [ text "IncheiereRefuz" ]
        , CauzaRefuz.view data.cauza (\v -> c { data | cauza = v })
        , RichTextEditor.view
            { buttonLabel = "Editează"
            , content = template data
            , onOpen = callback incheiereRefuz
            , onResponse = \s -> c { data | html = s }
            }
        ]


template : Data -> List (Html msg)
template data =
    -- TODO: find the real template
    [ h1 [] [ text "IncheiereRefuz" ]
    , p [] [ text <| toString <| data ]
    ]
