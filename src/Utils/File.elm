module Utils.File exposing (File, empty, setPath)


type alias File =
    { path : String
    }


empty : File
empty =
    { path = "" }


setPath : File -> String -> File
setPath model newPath =
    { model | path = newPath }
