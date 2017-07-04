module Dosar.Persoana.PersoanaJuridica exposing (PersoanaJuridica, newValue, view)

import Html exposing (Html, ul, li, label, input, textarea, text)
import Widgets.Fields exposing (textField, largeTextField, dateField)


type alias PersoanaJuridica =
    { denumire : String
    , codFiscal : String
    , dateBancare : String
    , adresa : String
    , note : String
    }


newValue : PersoanaJuridica
newValue =
    { denumire = ""
    , codFiscal = ""
    , dateBancare = ""
    , adresa = ""
    , note = ""
    }


view : PersoanaJuridica -> (PersoanaJuridica -> msg) -> Html msg
view p callback =
    ul []
        [ li [] [ textField "Denumire:" p.denumire (\v -> callback { p | denumire = v }) ]
        , li [] [ textField "Cod fiscal:" p.codFiscal (\v -> callback { p | codFiscal = v }) ]
        , li [] [ largeTextField "Date bancare:" p.dateBancare (\v -> callback { p | dateBancare = v }) ]
        , li [] [ largeTextField "Adresa:" p.adresa (\v -> callback { p | adresa = v }) ]
        , li [] [ largeTextField "Note:" p.note (\v -> callback { p | note = v }) ]
        ]
