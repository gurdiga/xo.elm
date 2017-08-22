module Utils.Money exposing (Money(..), Currency(..), currenciesWithLabels)


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
