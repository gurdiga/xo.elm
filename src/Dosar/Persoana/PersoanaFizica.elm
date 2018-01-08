module Dosar.Persoana.PersoanaFizica exposing (Model, empty, view, Msg, update)

import Html
import Html.Styled exposing (map, toUnstyled, fromUnstyled, Html, ul, li)
import Html.Styled.Attributes exposing (css)
import Widgets.TextField as TextField
import Widgets.LargeTextField as LargeTextField
import Widgets.DateField as DateField
import Utils.MyDate as MyDate
import Dosar.Persoana.PersoanaFizica.Css as Css


type Msg
    = UpdateNume TextField.Msg
    | UpdatePrenume TextField.Msg
    | UpdateDataNasterii DateField.Msg
    | UpdateCnp TextField.Msg
    | UpdateAdresa LargeTextField.Msg
    | UpdateNote LargeTextField.Msg


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        UpdateNume textFieldMsg ->
            Model { model | nume = TextField.update textFieldMsg model.nume }

        UpdatePrenume textFieldMsg ->
            Model { model | prenume = TextField.update textFieldMsg model.prenume }

        UpdateDataNasterii dateFieldMsg ->
            Model { model | dataNasterii = DateField.update dateFieldMsg model.dataNasterii }

        UpdateCnp textFieldMsg ->
            Model { model | cnp = TextField.update textFieldMsg model.cnp }

        UpdateAdresa largeTextFieldMsg ->
            Model { model | adresa = LargeTextField.update largeTextFieldMsg model.adresa }

        UpdateNote largeTextFieldMsg ->
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
        [ li [] [ TextField.view "Nume:" model.nume |> Html.map UpdateNume |> fromUnstyled ]
        , li [] [ TextField.view "Prenume:" model.prenume |> Html.map UpdatePrenume |> fromUnstyled ]
        , li [] [ DateField.view "Data nasterii:" model.dataNasterii |> map UpdateDataNasterii ]
        , li [] [ TextField.view "CNP:" model.cnp |> Html.map UpdateCnp |> fromUnstyled ]
        , li [] [ LargeTextField.view "Adresa:" model.adresa |> map UpdateAdresa ]
        , li [] [ LargeTextField.view "Note:" model.note |> map UpdateNote ]
        ]
