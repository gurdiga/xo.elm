module Dosar.Persoana.PersoanaFizica exposing (PersoanaFizica, empty, view)

import Html exposing (Html, ul, li)
import Utils.MyDate as MyDate exposing (MyDate)
import Widgets.Fields exposing (textField, largeTextField)
import Utils.MyDate as MyDate


type alias PersoanaFizica =
    { nume : String
    , prenume : String
    , dataNasterii : MyDate
    , cnp : String
    , adresa : String
    , note : String
    }


empty : PersoanaFizica
empty =
    { nume = ""
    , prenume = ""
    , dataNasterii = MyDate.empty
    , cnp = ""
    , adresa = ""
    , note = ""
    }


view : PersoanaFizica -> (PersoanaFizica -> msg) -> Html msg
view p callback =
    ul []
        [ li [] [ textField "Nume:" p.nume (\v -> callback { p | nume = v }) ]
        , li [] [ textField "Prenume:" p.prenume (\v -> callback { p | prenume = v }) ]
        , li [] [ MyDate.view "Data nasterii:" p.dataNasterii (\v -> callback { p | dataNasterii = v }) ]
        , li [] [ textField "CNP:" p.cnp (\v -> callback { p | cnp = v }) ]
        , li [] [ largeTextField "Adresa:" p.adresa (\v -> callback { p | adresa = v }) ]
        , li [] [ largeTextField "Note:" p.note (\v -> callback { p | note = v }) ]
        ]
