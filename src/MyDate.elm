module MyDate exposing (MyDate, newValue, parse, format)

import Date exposing (Date)
import Regex exposing (regex)


type alias MyDate =
    { string : String
    , date : Maybe Date
    , validationMessage : String
    }


newValue : MyDate
newValue =
    { string = ""
    , date = Nothing
    , validationMessage = ""
    }


parse : String -> MyDate
parse dateString =
    let
        myDate =
            { string = dateString
            , date = Nothing
            , validationMessage = ""
            }
    in
        if not (Regex.contains (regex "^\\d{2}\\.\\d{2}\\.\\d{4}$") dateString) then
            { myDate | validationMessage = "Data trebuie să aibă formatul DD.LL.AAAA" }
        else
            let
                dayString =
                    -- DD.LL.AAAA
                    -- ^^
                    String.slice 0 2 dateString

                monthString =
                    -- DD.LL.AAAA
                    --    ^^
                    String.slice 3 5 dateString

                yearString =
                    -- DD.LL.AAAA
                    --       ^^^^
                    String.slice 6 10 dateString
            in
                case
                    ( validateDayString dayString
                    , validateMonthString monthString
                    , validateYearString yearString
                    )
                of
                    ( Err e, _, _ ) ->
                        { myDate | validationMessage = "Ziua datei este incorectă: " ++ dayString }

                    ( Ok _, Err e, _ ) ->
                        { myDate | validationMessage = ("Luna datei este incorectă: " ++ monthString) }

                    ( Ok _, Ok _, Err e ) ->
                        { myDate | validationMessage = ("Anul datei este incorect: " ++ yearString) }

                    ( Ok day, Ok month, Ok year ) ->
                        case validateDayForMonthAndYear day month year of
                            Err errorMessage ->
                                { myDate | validationMessage = errorMessage }

                            Ok day ->
                                let
                                    isoDateString =
                                        yearString ++ "-" ++ monthString ++ "-" ++ dayString
                                in
                                    case Date.fromString isoDateString of
                                        Ok date ->
                                            { myDate | date = Just date }

                                        Err errorMessage ->
                                            { myDate | validationMessage = errorMessage }


validateDayString : String -> Result String Int
validateDayString dayString =
    let
        day =
            String.toInt dayString
    in
        case day of
            Err e ->
                Err e

            Ok day ->
                if day > 31 then
                    Err dayString
                else
                    Ok day


validateMonthString : String -> Result String Int
validateMonthString monthString =
    let
        monthNumber =
            String.toInt monthString
    in
        case monthNumber of
            Err e ->
                Err e

            Ok monthNumber ->
                if monthNumber > 13 then
                    Err monthString
                else
                    Ok monthNumber


validateYearString : String -> Result String Int
validateYearString yearString =
    String.toInt yearString


validateDayForMonthAndYear : Int -> Int -> Int -> Result String Int
validateDayForMonthAndYear day month year =
    let
        monthsWith31Days =
            [ 1, 3, 5, 7, 8, 10, 12 ]

        monthsWith30Days =
            [ 4, 6, 9, 11 ]
    in
        if List.member month monthsWith31Days then
            if day < 32 then
                Ok day
            else
                Err ("Luna " ++ (toString month) ++ " are 31 de zile")
        else if List.member month monthsWith30Days then
            if day < 31 then
                Ok day
            else
                Err ("Luna " ++ (toString month) ++ " are 30 de zile")
        else if isLeapYear year then
            -- February
            if day < 30 then
                Ok day
            else
                Err ("Luna februarie are 29 de zile în " ++ (toString year))
        else if day < 29 then
            Ok day
        else
            Err ("Luna februarie are 28 de zile în " ++ (toString year))


isLeapYear : Int -> Bool
isLeapYear year =
    if year % 400 == 0 then
        True
    else if year % 100 == 0 then
        False
    else if year % 4 == 0 then
        True
    else
        False


format : MyDate -> Result String String
format myDate =
    case myDate.date of
        Just date ->
            Ok
                ((String.padLeft 2 '0' (toString (Date.day date)))
                    ++ "."
                    ++ (String.padLeft 2 '0' (toString (monthNumber date)))
                    ++ "."
                    ++ (toString (Date.year date))
                )

        Nothing ->
            if myDate.validationMessage == "" then
                Err ("Dată invalidă: " ++ myDate.string)
            else
                Err myDate.validationMessage


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
