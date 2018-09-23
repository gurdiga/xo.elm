module Utils.File exposing (File, empty, setPath, toString)


type alias File =
    { path : String
    }


toString : File -> String
toString file =
    file.path


empty : File
empty =
    { path = "" }


setPath : File -> String -> File
setPath model newPath =
    { model | path = newPath }
