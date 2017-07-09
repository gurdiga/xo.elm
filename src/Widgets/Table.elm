module Widgets.Table exposing (view)

import Html exposing (Html, table, thead, tbody, tr, th, td, text)
import Utils.List as ListUtils


type alias HeaderString =
    String


type alias CellRenderer record msg =
    record -> RecordCallback record msg -> Html msg


type alias RecordCallback record msg =
    record -> msg


type alias ListCallback record msg =
    List record -> msg


view : List record -> ListCallback record msg -> List ( HeaderString, CellRenderer record msg ) -> Html msg
view list callback columns =
    let
        headers =
            List.map Tuple.first columns

        renderers =
            List.map Tuple.second columns
    in
        table []
            [ thead [] [ headRow headers ]
            , tbody [] (List.indexedMap (dataRow list callback renderers) list)
            ]


headRow : List String -> Html msg
headRow headers =
    let
        headCell header =
            th [] [ text header ]
    in
        tr [] <| List.map headCell headers


dataRow : List record -> ListCallback record msg -> List (CellRenderer record msg) -> Int -> record -> Html msg
dataRow list listCallback renderers index record =
    let
        dataCell renderer =
            td [] [ renderer record (\v -> listCallback (ListUtils.replace list index v)) ]
    in
        tr [] <| List.map dataCell renderers
