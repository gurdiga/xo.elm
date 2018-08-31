module Utils.Money exposing (Currency(..), Money(..), currenciesWithLabels, format)


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
    String.fromFloat amount ++ " " ++ Debug.toString currency
