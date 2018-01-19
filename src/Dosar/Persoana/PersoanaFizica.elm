module Dosar.Persoana.PersoanaFizica exposing (Model, Msg, empty, update, view)

import Dosar.Persoana.PersoanaFizica.Css as Css
import Html.Styled exposing (Html, li, map, ul)
import Html.Styled.Attributes exposing (css)
import Utils.MyDate as MyDate
import Widgets.DateField as DateField
import Widgets.LargeTextField as LargeTextField
import Widgets.TextField as TextField


type Msg
    = SetNume TextField.Msg
    | SetPrenume TextField.Msg
    | SetDataNasterii DateField.Msg
    | SetCnp TextField.Msg
    | SetAdresa LargeTextField.Msg
    | SetNote LargeTextField.Msg


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        SetNume textFieldMsg ->
            Model { model | nume = TextField.update textFieldMsg model.nume }

        SetPrenume textFieldMsg ->
            Model { model | prenume = TextField.update textFieldMsg model.prenume }

        SetDataNasterii dateFieldMsg ->
            Model { model | dataNasterii = DateField.update dateFieldMsg model.dataNasterii }

        SetCnp textFieldMsg ->
            Model { model | cnp = TextField.update textFieldMsg model.cnp }

        SetAdresa largeTextFieldMsg ->
            Model { model | adresa = LargeTextField.update largeTextFieldMsg model.adresa }

        SetNote largeTextFieldMsg ->
            Model { model | note = LargeTextField.update largeTextFieldMsg model.note }


type Model
    = Model
        { nume : String
        , prenume : String
        , dataNasterii : MyDate.Model
        , cnp : String
        , adresa : String
        , note : String
        }


empty : Model
empty =
    Model
        { nume = ""
        , prenume = ""
        , dataNasterii = MyDate.empty
        , cnp = ""
        , adresa = ""
        , note = ""
        }


view : Model -> Html Msg
view (Model model) =
    ul [ css [ Css.ul ] ]
        [ li [] [ TextField.view "Nume:" model.nume |> map SetNume ]
        , li [] [ TextField.view "Prenume:" model.prenume |> map SetPrenume ]
        , li [] [ DateField.view "Data nasterii:" model.dataNasterii |> map SetDataNasterii ]
        , li [] [ TextField.view "CNP:" model.cnp |> map SetCnp ]
        , li [] [ LargeTextField.view "Adresa:" model.adresa |> map SetAdresa ]
        , li [] [ LargeTextField.view "Note:" model.note |> map SetNote ]
        ]
