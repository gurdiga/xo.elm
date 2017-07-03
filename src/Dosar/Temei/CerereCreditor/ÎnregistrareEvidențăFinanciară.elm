module Dosar.Temei.CerereCreditor.ÎnregistrareEvidențăFinanciară exposing (ÎnregistrareEvidențăFinanciară, newValue, view)

import Html exposing (Html, text)
import Money exposing (Money(Money), Currency(MDL))
import MyDate exposing (MyDate)


type alias ÎnregistrareEvidențăFinanciară =
    { data : MyDate
    , suma : Money
    , note : String
    }


newValue : ÎnregistrareEvidențăFinanciară
newValue =
    { data = MyDate.newValue
    , suma = Money 0 MDL
    , note = ""
    }


view : ÎnregistrareEvidențăFinanciară -> (ÎnregistrareEvidențăFinanciară -> msg) -> Html msg
view înregistrareEvidențăFinanciară callback =
    text ("ÎnregistrareEvidențăFinanciară" ++ (toString înregistrareEvidențăFinanciară))
