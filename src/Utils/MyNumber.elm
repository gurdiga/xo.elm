module Utils.MyNumber exposing (format)

import String.Extra


type NumberLocale
    = NumberLocale
        { decimalSeparator : String
        , groupSeparator : String
        }


romanianNumberLocale : NumberLocale
romanianNumberLocale =
    NumberLocale
        { decimalSeparator = ","
        , groupSeparator = "."
        }


format : Float -> String
format n =
    n
        |> toString
        |> setDecimalSeparator
        |> addGroupSeparators


setDecimalSeparator : String -> String
setDecimalSeparator s =
    String.Extra.replace "." "," s


addGroupSeparators : String -> String
addGroupSeparators s =
    let
        (NumberLocale { decimalSeparator }) =
            romanianNumberLocale
    in
        case String.split decimalSeparator s of
            -- This cant happen.
            [] ->
                s

            wholePart :: [] ->
                formatGroups wholePart

            wholePart :: decimalPart :: _ ->
                (formatGroups wholePart) ++ decimalSeparator ++ decimalPart


formatGroups : String -> String
formatGroups s =
    let
        (NumberLocale { groupSeparator }) =
            romanianNumberLocale
    in
        s
            |> String.reverse
            |> String.Extra.break 3
            |> String.join groupSeparator
            |> String.reverse
