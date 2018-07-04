module Dosar.Persoana exposing (Model, Msg, initialModel, update, view)

import Dosar.Persoana.Css as Css
import Dosar.Persoana.PersoanaFizica as PersoanaFizica
import Dosar.Persoana.PersoanaJuridica as PersoanaJuridica
import Html.Styled exposing (Html, fieldset, map)
import Html.Styled.Attributes exposing (css)
import Widgets.Select3 as Select3


type Msg
    = SetPersoanaFizica PersoanaFizica.Msg
    | SetPersoanaJuridica PersoanaJuridica.Msg
    | SetGenPersoana (Select3.Msg Persoana)


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

        SetGenPersoana select3Msg ->
            receivePersoana (Model model) (Select3.update select3Msg model.ui.select)


receivePersoana : Model -> Select3.Model Persoana -> Model
receivePersoana (Model ({ ui } as model)) newSelect =
    Model
        { model
            | ui = { ui | select = newSelect }
            , persoana = Select3.selectedValue newSelect
        }


type Model
    = Model
        { persoana : Persoana
        , ui : Ui
        }


type alias Ui =
    { select : Select3.Model Persoana
    }


type Persoana
    = PersoanaFizica PersoanaFizica.Model
    | PersoanaJuridica PersoanaJuridica.Model


initialModel : Model
initialModel =
    Model
        { persoana = PersoanaFizica PersoanaFizica.initialModel
        , ui =
            { select = Select3.initialModel initialPersoana valuesWithLabels
            }
        }


initialPersoana : Persoana
initialPersoana =
    PersoanaFizica PersoanaFizica.initialModel


view : Model -> Html Msg
view (Model model) =
    fieldset [ css [ Css.fieldset ] ]
        [ Select3.view "Gen persoană:" model.ui.select |> map SetGenPersoana
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
