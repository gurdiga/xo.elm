module Dosar.Actiune.IncheiereRefuz exposing (IncheiereRefuz, newValue, view)

import Dosar.Actiune.IncheiereRefuz.CauzaRefuz as CauzaRefuz exposing (CauzaRefuz)
import Html exposing (Html, fieldset, legend, div, h1, p, button, text)
import RichTextEditor


type IncheiereRefuz
    = IncheiereRefuz Data


type alias Data =
    { cauza : CauzaRefuz
    , html : String
    }


newValue : IncheiereRefuz
newValue =
    IncheiereRefuz
        { cauza = CauzaRefuz.newValue
        , html = ""
        }


view : IncheiereRefuz -> (IncheiereRefuz -> Cmd msg -> Sub msg -> msg) -> Html msg
view incheiereRefuz callback =
    let
        (IncheiereRefuz data) =
            incheiereRefuz

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
                , onResponse = (\s -> c { data | html = s })
                }
            ]


template : Data -> List (Html msg)
template data =
    -- TODO: find the real template
    [ h1 [] [ text "IncheiereRefuz" ]
    , p [] [ text <| toString <| data ]
    ]