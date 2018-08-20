module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.EditableList2 exposing (Config, State, config, state, view)

import Html.Styled exposing (Html, button, fieldset, legend, li, map, p, text, ul)


type State
    = State StateData


type alias StateData =
    {}


state : StateData -> State
state =
    State


type Config a msg
    = Config (ConfigData a msg)


type alias ViewItem a msg =
    Int -> a -> Html msg


type alias ConfigData a msg =
    { toMsg : State -> msg
    , viewNoItems : Html msg
    , viewItem : ViewItem a msg
    }


config : ConfigData a msg -> Config a msg
config =
    Config


view : Config a msg -> State -> List a -> Html msg
view (Config config) state items =
    fieldset []
        [ legend [] [ text "EditableList2" ]
        , if List.isEmpty items then
            p [] [ config.viewNoItems ]
          else
            ul [] (List.indexedMap config.viewItem items)
        , ul []
            [ li [] [ text "state", text (toString state) ]
            , li [] [ text "config", text (toString config) ]
            , li [] [ text "items", text (toString items) ]
            ]
        ]
