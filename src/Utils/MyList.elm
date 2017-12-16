module Utils.MyList
    exposing
        ( replace
        , find
        , dropUntil
        )


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
