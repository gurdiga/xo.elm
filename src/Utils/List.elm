module Utils.List exposing (replace)


replace : List a -> Int -> a -> List a
replace list index newValue =
    let
        mapper i v =
            if i == index then
                newValue
            else
                v
    in
        List.indexedMap mapper list
