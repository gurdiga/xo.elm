module Dosar.Temei.PreluareDocumentExecutoriuStramutat.IncheiereStramutare exposing (IncheiereStramutare, newValue, view)

import Html exposing (Html, text)


type IncheiereStramutare
    = IncheiereStramutare {}


newValue : IncheiereStramutare
newValue =
    IncheiereStramutare {}


view : IncheiereStramutare -> (IncheiereStramutare -> msg) -> Html msg
view incheiereStramutare callback =
    text (toString incheiereStramutare)
