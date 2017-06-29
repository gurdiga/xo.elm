module Money exposing (Money(..), Currency(..))


type alias Amount =
    Float


type Currency
    = MDL
    | EUR
    | USD


type Money
    = Money Amount Currency
