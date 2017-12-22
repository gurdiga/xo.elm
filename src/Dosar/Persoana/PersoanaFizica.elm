module Dosar.Persoana.PersoanaFizica exposing (Model, empty, view, Msg, update)

import Html exposing (Html, ul, li)


-- import Widgets.Fields exposing (textField, largeTextField)

import Widgets.TextField as TextField
import Utils.MyDate as MyDate


type Msg
    = UpdateNume TextField.Msg


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        UpdateNume textFieldMsg ->
            Model { model | nume = TextField.update textFieldMsg model.nume }


type Model
    = Model
        { nume : TextField.Model
        , prenume : String
        , dataNasterii : MyDate.Model
        , cnp : String
        , adresa : String
        , note : String
        }


empty : Model
empty =
    Model
        { nume = TextField.initialModel
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

        --
        -- TODO: Continue here.
        --
        -- , li [] [ textField "Prenume:" p.prenume (\v -> callback { p | prenume = v }) ]
        -- , li [] [ MyDate.view "Data nasterii:" p.dataNasterii (\v -> callback { p | dataNasterii = v }) ]
        -- , li [] [ textField "CNP:" p.cnp (\v -> callback { p | cnp = v }) ]
        -- , li [] [ largeTextField "Adresa:" p.adresa (\v -> callback { p | adresa = v }) ]
        -- , li [] [ largeTextField "Note:" p.note (\v -> callback { p | note = v }) ]
        ]
