module Dosar.Persoana.PersoanaFizica exposing (Model, Msg, initialModel, update, view, viewEditForm)

import Html exposing (Html, li, map, text, ul)
import Utils.MyDate as MyDate
import Widgets.DateField as DateField
import Widgets.LargeTextField as LargeTextField
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
        [ li [] [ TextField.view "Nume:" model.nume SetNume ]
        , li [] [ TextField.view "Prenume:" model.prenume SetPrenume ]
        , li [] [ DateField.view "Data nasterii:" model.dataNasterii SetDataNasterii ]
        , li [] [ TextField.view "CNP:" model.cnp SetCnp ]
        , li [] [ LargeTextField.view "Adresa:" model.adresa SetAdresa ]
        , li [] [ LargeTextField.view "Note:" model.note SetNote ]
        ]


type Msg
    = SetNume String
    | SetPrenume String
    | SetDataNasterii MyDate.Model
    | SetCnp String
    | SetAdresa String
    | SetNote String


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetNume v ->
            { model | nume = v }

        SetPrenume v ->
            { model | prenume = v }

        SetDataNasterii v ->
            { model | dataNasterii = v }

        SetCnp v ->
            { model | cnp = v }

        SetAdresa v ->
            { model | adresa = v }

        SetNote v ->
            { model | note = v }
