module Warrant exposing (Type, newValue)


type Type
    = Warrant -- Fields + Maybe ScannedImageValue


newValue : Type
newValue =
    Warrant
