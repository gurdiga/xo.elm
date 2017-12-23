module Dosar.Persoana exposing (Model, initialModel, view, update, Msg)

import Html exposing (Html, fieldset)
import Html.Attributes exposing (style)
import Dosar.Persoana.Css as Css
import Dosar.Persoana.PersoanaFizica as PersoanaFizica


-- import Dosar.Persoana.PersoanaJuridica as PersoanaJuridica exposing (PersoanaJuridica)

import Widgets.Select3 as Select3


type Msg
    = UpdateFields PersoanaFizica.Msg
    | UpdateGenPersoana (Select3.Msg Persoana)


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        UpdateFields persoanaFizicaMsg ->
            case model.persoana of
                PersoanaFizica persoanaFizica ->
                    Model { model | persoana = PersoanaFizica (PersoanaFizica.update persoanaFizicaMsg persoanaFizica) }

        UpdateGenPersoana select3Msg ->
            let
                this =
                    Model
                        { model
                            | ui = (\ui -> { ui | select = newSelect }) model.ui
                            , persoana = Select3.selectedValue newSelect
                        }

                newSelect =
                    Select3.update select3Msg model.ui.select
            in
                this


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
        , ui =
            { select = Select3.initialModel initialPersoana valuesWithLabels
            }
        }


initialPersoana : Persoana
initialPersoana =
    PersoanaFizica PersoanaFizica.empty


view : Model -> Html Msg
view (Model model) =
    fieldset [ style Css.fieldset ]
        [ Select3.view "Gen persoana:" model.ui.select |> Html.map UpdateGenPersoana
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
            PersoanaFizica.view persoanaFizica |> Html.map UpdateFields



--         PersoanaJuridica p ->
--             PersoanaJuridica.view p (\v -> callback (PersoanaJuridica v))
