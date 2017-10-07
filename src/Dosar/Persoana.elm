module Dosar.Persoana exposing (Persoana, empty, view)

import Html exposing (Html, fieldset, legend, label, text)
import Dosar.Persoana.PersoanaFizica as PersoanaFizica exposing (PersoanaFizica)
import Dosar.Persoana.PersoanaJuridica as PersoanaJuridica exposing (PersoanaJuridica)
import MyMaterial.Select as Select


type Persoana
    = PersoanaFizica PersoanaFizica
    | PersoanaJuridica PersoanaJuridica


empty : Persoana
empty =
    PersoanaFizica PersoanaFizica.empty


view : Persoana -> (Persoana -> msg) -> Html msg
view persoana callback =
    let
        defaultValueFor persoana =
            case persoana of
                PersoanaFizica _ ->
                    PersoanaFizica PersoanaFizica.empty

                PersoanaJuridica _ ->
                    PersoanaJuridica PersoanaJuridica.empty
    in
        fieldset []
            [ legend [] [ text "Persoana" ]
            , Select.view
                { labelText = "Gen persoana:"
                , valuesWithLabels = valuesWithLabels
                , defaultValue = (defaultValueFor persoana)
                , callback = callback
                }
            , fields persoana callback
            ]


valuesWithLabels : List ( Persoana, String )
valuesWithLabels =
    [ ( PersoanaFizica PersoanaFizica.empty, "fizica" )
    , ( PersoanaJuridica PersoanaJuridica.empty, "juridica" )
    ]


fields : Persoana -> (Persoana -> msg) -> Html msg
fields persoana callback =
    case persoana of
        PersoanaFizica p ->
            PersoanaFizica.view p (\v -> callback (PersoanaFizica v))

        PersoanaJuridica p ->
            PersoanaJuridica.view p (\v -> callback (PersoanaJuridica v))
