module Dosar.Temei.CerereCreditor.InregistrareEvidentaFinanciara exposing (InregistrareEvidentaFinanciara, newValue, view)

import Html exposing (Html, tr, td, text)
import Html.Attributes exposing (style)
import Money exposing (Money(Money), Currency(MDL))
import MyDate exposing (MyDate)


type alias InregistrareEvidentaFinanciara =
    { data : MyDate
    , suma : Money
    , note : String
    }


newValue : InregistrareEvidentaFinanciara
newValue =
    { data = MyDate.newValue
    , suma = Money 0 MDL
    , note = ""
    }


view : InregistrareEvidentaFinanciara -> (InregistrareEvidentaFinanciara -> msg) -> Html msg
view { data, suma, note } callback =
    let
        tdStyle =
            style [ ( "border", "1px solid silver" ) ]
    in
        tr []
            [ td [ tdStyle ] [ text (Result.withDefault "-" (MyDate.format data)) ]
            , td [ tdStyle ] [ text (toString suma) ]
            , td [ tdStyle ] [ text note ]
            ]
