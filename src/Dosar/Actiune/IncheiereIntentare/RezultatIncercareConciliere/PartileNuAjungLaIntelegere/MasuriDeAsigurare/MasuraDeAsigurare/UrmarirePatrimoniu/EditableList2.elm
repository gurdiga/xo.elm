module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.EditableList2 exposing (Config, State, config, state, view)

import Html.Styled exposing (Html, button, fieldset, legend, li, map, text, ul)


type State
    = State StateData


type alias StateData =
    {}


state : StateData -> State
state =
    State


type Config msg
    = Config (ConfigData msg)


type alias ConfigData msg =
    { toMsg : State -> msg
    }


config : ConfigData msg -> Config msg
config =
    Config


view : Config msg -> State -> List data -> Html msg
view (Config config) state data =
    fieldset []
        [ legend [] [ text "EditableList2" ]
        , ul []
            [ li [] [ text "state", text (toString state) ]
            , li [] [ text "config", text (toString config) ]
            , li [] [ text "data", text (toString data) ]
            ]
        ]
