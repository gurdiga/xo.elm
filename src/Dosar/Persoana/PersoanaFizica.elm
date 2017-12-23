module Dosar.Persoana.PersoanaFizica exposing (Model, empty, view, Msg, update)

import Html exposing (Html, ul, li)


-- import Widgets.Fields exposing (textField, largeTextField)

import Widgets.TextField as TextField
import Utils.MyDate as MyDate


type Msg
    = UpdateNume TextField.Msg
    | UpdatePrenume TextField.Msg


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        UpdateNume textFieldMsg ->
            Model
                { model | nume = TextField.update textFieldMsg model.nume }

        UpdatePrenume textFieldMsg ->
            Model { model | prenume = TextField.update textFieldMsg model.prenume }


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
    ul []
        [ li [] [ TextField.view "Nume:" model.nume |> Html.map UpdateNume ]
        , li [] [ TextField.view "Prenume:" model.prenume |> Html.map UpdatePrenume ]

        --
        -- TODO: Continue here.
        --
        -- , li [] [ MyDate.view "Data nasterii:" p.dataNasterii (\v -> callback { p | dataNasterii = v }) ]
        -- , li [] [ textField "CNP:" p.cnp (\v -> callback { p | cnp = v }) ]
        -- , li [] [ largeTextField "Adresa:" p.adresa (\v -> callback { p | adresa = v }) ]
        -- , li [] [ largeTextField "Note:" p.note (\v -> callback { p | note = v }) ]
        ]
