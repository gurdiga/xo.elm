module Dosar.Persoana exposing (Model, Msg, initialModel, update, view)

import Dosar.Persoana.Css as Css
import Dosar.Persoana.PersoanaFizica as PersoanaFizica
import Dosar.Persoana.PersoanaJuridica as PersoanaJuridica
import Html.Styled exposing (Html, fieldset, map)
import Html.Styled.Attributes exposing (css)
import Widgets.Select3 as Select3


type Msg
    = SetPersoanaFizica PersoanaFizica.Model PersoanaFizica.Msg
    | SetPersoanaJuridica PersoanaJuridica.Model PersoanaJuridica.Msg
    | SetGenPersoana (Select3.Msg Persoana)


update : Msg -> Model -> Model
update msg (Model model) =
    case Debug.log "----" msg of
        SetPersoanaFizica p msg ->
            Model { model | persoana = PersoanaFizica (PersoanaFizica.update msg p) }

        SetPersoanaJuridica p msg ->
            Model { model | persoana = PersoanaJuridica (PersoanaJuridica.update msg p) }

        SetGenPersoana select3Msg ->
            -- TODO: Why doesn’t this work? Changing the selected value doesn’t change the field set.
            Debug.log "model" <|
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
    fieldset [ css [ Css.fieldset ] ]
        [ Select3.view "Gen persoană:" model.ui.select |> map SetGenPersoana
        , fieldsView model.persoana
        ]


valuesWithLabels : List ( Persoana, String )
valuesWithLabels =
    [ ( PersoanaFizica PersoanaFizica.empty, "fizică" )
    , ( PersoanaJuridica PersoanaJuridica.empty, "juridică" )
    ]


fieldsView : Persoana -> Html Msg
fieldsView persoana =
    case persoana of
        PersoanaFizica p ->
            PersoanaFizica.view p |> map (SetPersoanaFizica p)

        PersoanaJuridica p ->
            PersoanaJuridica.view p |> map (SetPersoanaJuridica p)
