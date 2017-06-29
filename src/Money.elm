module Money exposing (Money(..), Currency(..), newValue, amount)


type alias Amount =
    Float


type Currency
    = MDL
    | EUR
    | USD


type Money
    = Money Amount Currency


newValue : Money
newValue =
    Money 0 MDL


amount : Money -> Float
amount money =
    case money of
        Money amount currency ->
            amount
