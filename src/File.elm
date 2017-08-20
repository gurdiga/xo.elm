module File exposing (File, empty)


type alias File =
    { path : String
    }


empty : File
empty =
    { path = "" }
