module Dosar.Persoana exposing (Model, Msg, initialModel, update, view)

import Dosar.Persoana.PersoanaFizica as PersoanaFizica
import Dosar.Persoana.PersoanaJuridica as PersoanaJuridica
import Html exposing (Html, fieldset, map)
import Widgets.Select4 as Select4


type Msg
    = SetPersoanaFizica PersoanaFizica.Msg
    | SetPersoanaJuridica PersoanaJuridica.Msg
    | SetGenPersoana Persoana


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        SetPersoanaFizica m ->
            case model.persoana of
                PersoanaFizica p ->
                    Model { model | persoana = PersoanaFizica (PersoanaFizica.update m p) }

                _ ->
                    Model model

        SetPersoanaJuridica m ->
            case model.persoana of
                PersoanaJuridica p ->
                    Model { model | persoana = PersoanaJuridica (PersoanaJuridica.update m p) }

                _ ->
                    Model model

        SetGenPersoana v ->
            Model { model | persoana = v }


type Model
    = Model
        { persoana : Persoana
        }


type Persoana
    = PersoanaFizica PersoanaFizica.Model
    | PersoanaJuridica PersoanaJuridica.Model


initialModel : Model
initialModel =
    Model
        { persoana = initialPersoana
        }


initialPersoana : Persoana
initialPersoana =
    PersoanaFizica PersoanaFizica.initialModel


view : Model -> Html Msg
view (Model model) =
    fieldset []
        [ Select4.view <|
            Select4.config
                { label = "Gen persoană:"
                , defaultValue = model.persoana
                , valuesWithLabels = valuesWithLabels
                , onInput = SetGenPersoana
                }
        , fieldsView model.persoana
        ]


valuesWithLabels : List ( Persoana, String )
valuesWithLabels =
    [ ( PersoanaFizica PersoanaFizica.initialModel, "fizică" )
    , ( PersoanaJuridica PersoanaJuridica.empty, "juridică" )
    ]


fieldsView : Persoana -> Html Msg
fieldsView persoana =
    case persoana of
        PersoanaFizica p ->
            PersoanaFizica.view p |> map SetPersoanaFizica

        PersoanaJuridica p ->
            PersoanaJuridica.view p |> map SetPersoanaJuridica
