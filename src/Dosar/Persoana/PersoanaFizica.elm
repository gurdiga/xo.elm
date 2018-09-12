module Dosar.Persoana.PersoanaFizica exposing (Model, Msg, initialModel, update, view, viewEditForm)

import Html exposing (Html, li, map, text, ul)
import Utils.MyDate as MyDate
import Widgets.DateField as DateField
import Widgets.LargeTextField2 as LargeTextField2
import Widgets.TextField as TextField


type alias Model =
    { nume : String
    , prenume : String
    , dataNasterii : MyDate.Model
    , cnp : String
    , adresa : String
    , note : String
    }


initialModel : Model
initialModel =
    { nume = ""
    , prenume = ""
    , dataNasterii = MyDate.empty
    , cnp = ""
    , adresa = ""
    , note = ""
    }


view : Model -> Html Msg
view model =
    ul []
        [ li [] [ text ("Nume: " ++ model.nume) ]
        , li [] [ text ("Prenume: " ++ model.prenume) ]
        , li [] [ text ("Data nasterii: " ++ (MyDate.format model.dataNasterii |> Result.withDefault "[invalid date]")) ]
        , li [] [ text ("CNP: " ++ model.cnp) ]
        , li [] [ text ("Adresa: " ++ model.adresa) ]
        , li [] [ text ("Note: " ++ model.note) ]
        ]


viewEditForm : Model -> Html Msg
viewEditForm model =
    ul []
        [ li [] [ TextField.view "Nume:" model.nume |> map SetNume ]
        , li [] [ TextField.view "Prenume:" model.prenume |> map SetPrenume ]
        , li [] [ DateField.view "Data nasterii:" model.dataNasterii |> map SetDataNasterii ]
        , li [] [ TextField.view "CNP:" model.cnp |> map SetCnp ]
        , li [] [ LargeTextField2.view "Adresa:" model.adresa SetAdresa ]
        , li [] [ LargeTextField2.view "Note:" model.note SetNote ]
        ]


type Msg
    = SetNume TextField.Msg
    | SetPrenume TextField.Msg
    | SetDataNasterii DateField.Msg
    | SetCnp TextField.Msg
    | SetAdresa String
    | SetNote String


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetNume textFieldMsg ->
            { model | nume = TextField.update textFieldMsg model.nume }

        SetPrenume textFieldMsg ->
            { model | prenume = TextField.update textFieldMsg model.prenume }

        SetDataNasterii dateFieldMsg ->
            { model | dataNasterii = DateField.update dateFieldMsg model.dataNasterii }

        SetCnp textFieldMsg ->
            { model | cnp = TextField.update textFieldMsg model.cnp }

        SetAdresa v ->
            { model | adresa = v }

        SetNote v ->
            { model | note = v }
