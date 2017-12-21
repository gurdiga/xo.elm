module Dosar.Persoana.PersoanaFizica exposing (Model, empty, view, Msg, update)

import Html exposing (Html, ul, li)


-- import Widgets.Fields exposing (textField, largeTextField)

import Utils.MyDate as MyDate


type Msg
    = Msg


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        Msg ->
            Model model


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
view p =
    Html.text "PersoanaFizica.view"



-- ul []
--     [ li [] [ textField "Nume:" p.nume (\v -> callback { p | nume = v }) ]
--     , li [] [ textField "Prenume:" p.prenume (\v -> callback { p | prenume = v }) ]
--     , li [] [ MyDate.view "Data nasterii:" p.dataNasterii (\v -> callback { p | dataNasterii = v }) ]
--     , li [] [ textField "CNP:" p.cnp (\v -> callback { p | cnp = v }) ]
--     , li [] [ largeTextField "Adresa:" p.adresa (\v -> callback { p | adresa = v }) ]
--     , li [] [ largeTextField "Note:" p.note (\v -> callback { p | note = v }) ]
--     ]
