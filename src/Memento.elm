module Memento exposing (Memento(Memento), view)

import Html exposing (Html, div, text)
import Widgets.Table as Table
import MyDate exposing (MyDate)


type Memento
    = Memento Data


type alias Data =
    { data : MyDate
    }


newValue : Memento
newValue =
    Memento
        { data = MyDate.newValue
        }


view : List Memento -> (List Memento -> msg) -> Html msg
view list callback =
    Table.view
        { data = List.map data list
        , callback = callback << fromData
        , columns =
            [ ( "Data", (\r c -> MyDate.viewUnlabeled r.data (\v -> c { r | data = v })) )
            ]
        , emptyView = text ""
        , newValue = data newValue
        }


fromData : List Data -> List Memento
fromData =
    List.map Memento


data : Memento -> Data
data (Memento data) =
    data
