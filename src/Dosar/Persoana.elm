module Dosar.Persoana exposing (Model, initialModel, view, update, Msg)

import Html exposing (Html, fieldset)
import Html.Styled exposing (map, toUnstyled)
import Html.Attributes exposing (style)
import Dosar.Persoana.Css as Css
import Dosar.Persoana.PersoanaFizica as PersoanaFizica
import Dosar.Persoana.PersoanaJuridica as PersoanaJuridica
import Widgets.Select3 as Select3


type Msg
    = SetPersoanaFizica PersoanaFizica.Model PersoanaFizica.Msg
    | SetPersoanaJuridica PersoanaJuridica.Model PersoanaJuridica.Msg
    | SetGenPersoana (Select3.Msg Persoana)


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        SetPersoanaFizica persoanaFizica persoanaFizicaMsg ->
            Model { model | persoana = PersoanaFizica (PersoanaFizica.update persoanaFizicaMsg persoanaFizica) }

        SetPersoanaJuridica persoanaJuridica persoanaJuridicaMsg ->
            Model { model | persoana = PersoanaJuridica (PersoanaJuridica.update persoanaJuridicaMsg persoanaJuridica) }

        SetGenPersoana select3Msg ->
            receiveSelectedValue (Model model) (Select3.update select3Msg model.ui.select)


type Model
    = Model
        { persoana : Persoana
        , ui : Ui
        }


type alias Ui =
    { select : Select3.Model Persoana
    }


receiveSelectedValue : Model -> Select3.Model Persoana -> Model
receiveSelectedValue (Model model) newSelect =
    Model
        { model
            | ui = setSelect model.ui newSelect
            , persoana = Select3.selectedValue newSelect
        }


setSelect : Ui -> Select3.Model Persoana -> Ui
setSelect ui select =
    { ui | select = select }


type Persoana
    = PersoanaFizica PersoanaFizica.Model
    | PersoanaJuridica PersoanaJuridica.Model


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
        [ Select3.view "Gen persoana:" model.ui.select |> map SetGenPersoana |> toUnstyled
        , fields model.persoana
        ]


valuesWithLabels : List ( Persoana, String )
valuesWithLabels =
    [ ( PersoanaFizica PersoanaFizica.empty, "fizica" )
    , ( PersoanaJuridica PersoanaJuridica.empty, "juridica" )
    ]


fields : Persoana -> Html Msg
fields persoana =
    case persoana of
        PersoanaFizica persoanaFizica ->
            PersoanaFizica.view persoanaFizica |> Html.map (SetPersoanaFizica persoanaFizica)

        PersoanaJuridica persoanaJuridica ->
            PersoanaJuridica.view persoanaJuridica |> Html.map (SetPersoanaJuridica persoanaJuridica)
