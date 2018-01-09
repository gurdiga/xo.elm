module Utils.Money exposing (Currency(..), Money(..), currenciesWithLabels, format)

import Utils.MyNumber as MyNumber


type alias Amount =
    Float


type Currency
    = MDL
    | EUR
    | USD


type Money
    = Money Amount Currency


currenciesWithLabels : List ( Currency, String )
currenciesWithLabels =
    [ ( MDL, "MDL" )
    , ( EUR, "EUR" )
    , ( USD, "USD" )
    ]


format : Money -> String
format (Money amount currency) =
    MyNumber.format amount ++ " " ++ toString currency
