module Utils.MyList exposing (dropUntil, find, get, replace)


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


get : List a -> Int -> Maybe a
get list index =
    if index < 0 then
        Nothing
    else
        list |> List.drop (index - 1) |> List.head


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
