module Utils.MyList exposing (dropUntil, find, get, last, replace)


replace : List a -> Int -> a -> List a
replace list index empty =
    let
        mapper i v =
            if i == index then
                empty
            else
                v
    in
    List.indexedMap mapper list


get : Int -> List a -> Maybe a
get index =
    List.drop index >> List.head


find : (a -> Bool) -> List a -> Maybe a
find predicate list =
    list
        |> List.filter predicate
        |> List.head


dropUntil : (a -> Bool) -> List a -> List a
dropUntil predicate xs =
    case xs of
        [] ->
            []

        x :: xs ->
            if predicate x then
                xs
            else
                dropUntil predicate xs


last : List a -> Maybe a
last =
    List.head << List.reverse
