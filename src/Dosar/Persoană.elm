module Dosar.Persoană exposing (Persoană, newValue, view)

import Html exposing (Html, fieldset, legend, label, text)
import Dosar.Persoană.PersoanăFizică as PersoanăFizică exposing (PersoanăFizică)
import Dosar.Persoană.PersoanăJuridică as PersoanăJuridică exposing (PersoanăJuridică)
import Widgets.Select as Select


type Persoană
    = PersoanăFizică PersoanăFizică
    | PersoanăJuridică PersoanăJuridică


newValue : Persoană
newValue =
    PersoanăFizică PersoanăFizică.newValue


view : Persoană -> (Persoană -> msg) -> Html msg
view persoană callback =
    fieldset []
        [ legend [] [ text "Persoană" ]
        , label []
            [ text "Gen persoană:"
            , Select.fromValuesWithLabels valuesWithLabels callback persoană
            ]
        , fields persoană callback
        ]


valuesWithLabels : List ( Persoană, String )
valuesWithLabels =
    [ ( PersoanăFizică PersoanăFizică.newValue, "fizică" )
    , ( PersoanăJuridică PersoanăJuridică.newValue, "juridică" )
    ]


fields : Persoană -> (Persoană -> msg) -> Html msg
fields persoană callback =
    case persoană of
        PersoanăFizică p ->
            PersoanăFizică.view p (\v -> callback (PersoanăFizică v))

        PersoanăJuridică p ->
            PersoanăJuridică.view p (\v -> callback (PersoanăJuridică v))
