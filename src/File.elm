module File exposing (File, newValue)


type alias File =
    { path : String
    }


newValue : File
newValue =
    { path = "" }
