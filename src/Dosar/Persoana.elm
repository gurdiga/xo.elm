module Dosar.Persoana exposing (Persoana, newValue, view)

import Html exposing (Html, fieldset, legend, label, text)
import Dosar.Persoana.PersoanaFizica as PersoanaFizica exposing (PersoanaFizica)
import Dosar.Persoana.PersoanaJuridica as PersoanaJuridica exposing (PersoanaJuridica)
import Widgets.Select as Select


type Persoana
    = PersoanaFizica PersoanaFizica
    | PersoanaJuridica PersoanaJuridica


newValue : Persoana
newValue =
    PersoanaFizica PersoanaFizica.newValue


view : Persoana -> (Persoana -> msg) -> Html msg
view persoana callback =
    let
        defaultValueFor persoana =
            case persoana of
                PersoanaFizica _ ->
                    PersoanaFizica PersoanaFizica.newValue

                PersoanaJuridica _ ->
                    PersoanaJuridica PersoanaJuridica.newValue
    in
        fieldset []
            [ legend [] [ text "Persoana" ]
            , label []
                [ text "Gen persoana:"
                , Select.fromValuesWithLabels valuesWithLabels (defaultValueFor persoana) callback
                ]
            , fields persoana callback
            ]


valuesWithLabels : List ( Persoana, String )
valuesWithLabels =
    [ ( PersoanaFizica PersoanaFizica.newValue, "fizica" )
    , ( PersoanaJuridica PersoanaJuridica.newValue, "juridica" )
    ]


fields : Persoana -> (Persoana -> msg) -> Html msg
fields persoana callback =
    case persoana of
        PersoanaFizica p ->
            PersoanaFizica.view p (\v -> callback (PersoanaFizica v))

        PersoanaJuridica p ->
            PersoanaJuridica.view p (\v -> callback (PersoanaJuridica v))
