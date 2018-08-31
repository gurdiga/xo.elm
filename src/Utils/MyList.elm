module Utils.MyList exposing (dropUntil, find, get, last, replace, replaceItem)


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


replaceItem : a -> a -> List a -> List a
replaceItem oldItem newItem =
    List.map
        (\item ->
            if item == oldItem then
                newItem
            else
                item
        )


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

        x :: rest ->
            if predicate x then
                rest
            else
                dropUntil predicate rest


last : List a -> Maybe a
last =
    List.head << List.reverse
