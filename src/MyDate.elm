module MyDate exposing (MyDate, format, parse)

import Date exposing (Date)


type alias MyDate =
    Result String Date


format : MyDate -> String
format myDate =
    case myDate of
        Ok date ->
            (String.padLeft 2 '0' (toString (Date.day date)))
                ++ "."
                ++ (String.padLeft 2 '0' (toString (monthNumber date)))
                ++ "."
                ++ (toString (Date.year date))

        Err errorMessage ->
            errorMessage


parse : String -> MyDate
parse date =
    Date.fromString date


monthNumber : Date -> Int
monthNumber date =
    case Date.month date of
        Date.Jan ->
            1

        Date.Feb ->
            2

        Date.Mar ->
            3

        Date.Apr ->
            4

        Date.May ->
            5

        Date.Jun ->
            6

        Date.Jul ->
            7

        Date.Aug ->
            8

        Date.Sep ->
            9

        Date.Oct ->
            10

        Date.Nov ->
            11

        Date.Dec ->
            12
