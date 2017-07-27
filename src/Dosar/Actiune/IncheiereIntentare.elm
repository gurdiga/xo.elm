module Dosar.Actiune.IncheiereIntentare exposing (IncheiereIntentare, newValue, view)

import Html exposing (Html, fieldset, legend, div, button, text)


type IncheiereIntentare
    = IncheiereIntentare


newValue : IncheiereIntentare
newValue =
    IncheiereIntentare


view : Maybe IncheiereIntentare -> (Maybe IncheiereIntentare -> Cmd msg -> Sub msg -> msg) -> Html msg
view maybeIncheiereIntentare callback =
    fieldset []
        [ legend [] [ text "IncheiereIntentare" ]
        , case maybeIncheiereIntentare of
            Just incheiereIntentare ->
                div [] [ text "There is one generated and saved, display it" ]

            Nothing ->
                div []
                    [ button [] [ text "Edit" ]
                    ]
        ]
