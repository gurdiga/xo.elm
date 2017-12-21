module Dosar.Persoana exposing (Model, initialModel, view, update, Msg)

import Html exposing (Html, fieldset, legend, label, text)
import Dosar.Persoana.PersoanaFizica as PersoanaFizica


-- import Dosar.Persoana.PersoanaJuridica as PersoanaJuridica exposing (PersoanaJuridica)

import Widgets.Select3 as Select3


type Msg
    = PersoanaFizicaMsg PersoanaFizica.Msg


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        PersoanaFizicaMsg persoanaFizicaMsg ->
            Model model


type Model
    = Model
        { persoana : Persoana
        , ui :
            { select : Select3.Model Persoana
            }
        }


type Persoana
    = PersoanaFizica PersoanaFizica.Model



-- | PersoanaJuridica PersoanaJuridica


initialModel : Model
initialModel =
    Model
        { persoana = PersoanaFizica PersoanaFizica.empty
        , ui = { select = Select3.initialModel initialPersoana valuesWithLabels }
        }


initialPersoana : Persoana
initialPersoana =
    PersoanaFizica PersoanaFizica.empty


view : Model -> Html Msg
view (Model model) =
    -- TODO: Continue here.
    let
        defaultValueFor persoana =
            case persoana of
                PersoanaFizica _ ->
                    PersoanaFizica PersoanaFizica.empty

        --                 PersoanaJuridica _ ->
        --                     PersoanaJuridica PersoanaJuridica.empty
    in
        fieldset []
            [ legend [] [ text "Persoana" ]

            -- , Select3.view "Gen persoana:" valuesWithLabels (defaultValueFor persoana)
            -- , Select3.view "Gen persoana:" select |> Html.map Select3Msg
            , fields model.persoana
            ]


valuesWithLabels : List ( Persoana, String )
valuesWithLabels =
    [ ( PersoanaFizica PersoanaFizica.empty, "fizica" )

    -- , ( PersoanaJuridica PersoanaJuridica.empty, "juridica" )
    ]


fields : Persoana -> Html Msg
fields persoana =
    case persoana of
        PersoanaFizica persoanaFizica ->
            PersoanaFizica.view persoanaFizica |> Html.map PersoanaFizicaMsg



--         PersoanaJuridica p ->
--             PersoanaJuridica.view p (\v -> callback (PersoanaJuridica v))
