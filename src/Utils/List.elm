module Utils.List exposing (replace)


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
