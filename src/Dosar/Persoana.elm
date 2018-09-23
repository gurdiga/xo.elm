module Dosar.Persoana exposing (Model, Msg, initialModel, update, view, viewEditForm)

import Dosar.Persoana.PersoanaFizica as PersoanaFizica
import Dosar.Persoana.PersoanaJuridica as PersoanaJuridica
import Html exposing (Html, fieldset, legend, li, map, text, ul)
import Widgets.Select as Select


type Model
    = PersoanaFizica PersoanaFizica.Model
    | PersoanaJuridica PersoanaJuridica.Model


initialModel : Model
initialModel =
    PersoanaFizica PersoanaFizica.initialModel


view : Model -> Html Msg
view model =
    case model of
        PersoanaFizica v ->
            PersoanaFizica.view v |> map (SetPersoanaFizica v)

        PersoanaJuridica v ->
            PersoanaJuridica.view v |> map (SetPersoanaJuridica v)


viewEditForm : Model -> Html Msg
viewEditForm model =
    fieldset []
        [ legend [] [ text "Persoana" ]
        , dropdown model
        , fields model
        ]


dropdown : Model -> Html Msg
dropdown model =
    Select.view
        { label = "Gen persoană:"
        , valuesWithLabels = valuesWithLabels
        , defaultValue = taggedInitialModelFor model
        , onInput = Set
        }


taggedInitialModelFor : Model -> Model
taggedInitialModelFor model =
    case model of
        PersoanaFizica _ ->
            PersoanaFizica PersoanaFizica.initialModel

        PersoanaJuridica _ ->
            PersoanaJuridica PersoanaJuridica.empty


valuesWithLabels : List ( Model, String )
valuesWithLabels =
    [ ( PersoanaFizica PersoanaFizica.initialModel, "fizică" )
    , ( PersoanaJuridica PersoanaJuridica.empty, "juridică" )
    ]


fields : Model -> Html Msg
fields model =
    case model of
        PersoanaFizica v ->
            PersoanaFizica.viewEditForm v |> map (SetPersoanaFizica v)

        PersoanaJuridica v ->
            PersoanaJuridica.viewEditForm v |> map (SetPersoanaJuridica v)


type Msg
    = Set Model
    | SetPersoanaFizica PersoanaFizica.Model PersoanaFizica.Msg
    | SetPersoanaJuridica PersoanaJuridica.Model PersoanaJuridica.Msg


update : Msg -> Model -> Model
update msg _ =
    case msg of
        Set v ->
            v

        SetPersoanaFizica v m ->
            PersoanaFizica (PersoanaFizica.update m v)

        SetPersoanaJuridica v m ->
            PersoanaJuridica (PersoanaJuridica.update m v)
