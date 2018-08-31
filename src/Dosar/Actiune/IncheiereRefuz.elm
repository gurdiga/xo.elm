module Dosar.Actiune.IncheiereRefuz exposing (Model, Msg, initialModel, update, view)

-- import Dosar.Actiune.IncheiereRefuz.CauzaRefuz as CauzaRefuz exposing (CauzaRefuz)

import Html exposing (Html, button, div, fieldset, h1, legend, map, p, text)


-- import Utils.RichTextEditor as RichTextEditor


type alias Model =
    { --  cauza : CauzaRefuz
      -- , html : String
    }


initialModel : Model
initialModel =
    { --  cauza = CauzaRefuz.empty
      -- , html = ""
    }


view : Model -> Html msg
view model =
    fieldset []
        [ legend [] [ text "IncheiereRefuz" ]
        , text "TODO"

        -- , CauzaRefuz.view data.cauza (\v -> c { data | cauza = v })
        -- , RichTextEditor.view
        --     { buttonLabel = "Editează"
        --     , content = template data
        --     , onOpen = callback incheiereRefuz
        --     , onResponse = \s -> c { data | html = s }
        --     }
        ]


template : Model -> List (Html msg)
template model =
    -- TODO: find the real template
    [ h1 [] [ text "IncheiereRefuz" ]
    , p [] [ text "TODO" ]
    ]


type Msg
    = Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        Msg ->
            model
