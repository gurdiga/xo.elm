module Dosar.Persoană.PersoanăFizică exposing (PersoanăFizică, newValue, view)

import Html exposing (Html, ul, li, label, input, textarea, text)
import Html.Attributes exposing (value)
import Html.Events exposing (onInput)
import MyDate exposing (MyDate)
import Widgets.Fields exposing (textField, largeTextField, dateField)


type alias PersoanăFizică =
    { nume : String
    , prenume : String
    , dataNașterii : MyDate
    , cnp : String
    , adresa : String
    , note : String
    }


newValue : PersoanăFizică
newValue =
    { nume = ""
    , prenume = ""
    , dataNașterii = MyDate.newValue
    , cnp = ""
    , adresa = ""
    , note = ""
    }


view : PersoanăFizică -> (PersoanăFizică -> msg) -> Html msg
view p callback =
    ul []
        [ li [] [ textField "Nume:" p.nume (\v -> callback { p | nume = v }) ]
        , li [] [ textField "Prenume:" p.prenume (\v -> callback { p | prenume = v }) ]
        , li [] [ dateField "Data nașterii:" p.dataNașterii (\v -> callback { p | dataNașterii = v }) ]
        , li [] [ textField "CNP:" p.cnp (\v -> callback { p | cnp = v }) ]
        , li [] [ largeTextField "Adresa:" p.adresa (\v -> callback { p | adresa = v }) ]
        , li [] [ largeTextField "Note:" p.note (\v -> callback { p | note = v }) ]
        ]
