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

        SetAdresa largeTextFieldMsg ->
            { model | adresa = LargeTextField.update largeTextFieldMsg model.adresa }

        SetNote largeTextFieldMsg ->
            { model | note = LargeTextField.update largeTextFieldMsg model.note }


type alias Model =
    { nume : String
    , prenume : String
    , dataNasterii : MyDate.Model
    , cnp : String
    , adresa : String
    , note : String
    }


empty : Model
empty =
    { nume = ""
    , prenume = ""
    , dataNasterii = MyDate.empty
    , cnp = ""
    , adresa = ""
    , note = ""
    }


view : Model -> Html Msg
view model =
    ul [ css [ Css.ul ] ]
        [ li [] [ TextField.view "Nume:" model.nume |> map SetNume ]
        , li [] [ TextField.view "Prenume:" model.prenume |> map SetPrenume ]
        , li [] [ DateField.view "Data nasterii:" model.dataNasterii |> map SetDataNasterii ]
        , li [] [ TextField.view "CNP:" model.cnp |> map SetCnp ]
        , li [] [ LargeTextField.view "Adresa:" model.adresa |> map SetAdresa ]
        , li [] [ LargeTextField.view "Note:" model.note |> map SetNote ]
        ]
