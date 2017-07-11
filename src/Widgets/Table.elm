module Widgets.Table exposing (view)

import Html exposing (Html, div, table, thead, tbody, tr, th, td, button, text)
import Html.Events exposing (onClick)
import Utils.List as ListUtils


type alias Input record msg =
    { data : List record
    , callback : ListCallback record msg
    , columns : Columns record msg
    , emptyView : Html msg
    , newValue : record
    }


type alias Columns record msg =
    List ( HeaderLabel, CellRenderer record msg )


type alias HeaderLabel =
    String


type alias CellRenderer record msg =
    record -> RecordCallback record msg -> Html msg


type alias RecordCallback record msg =
    record -> msg


type alias ListCallback record msg =
    List record -> msg


view : Input record msg -> Html msg
view { data, callback, columns, emptyView, newValue } =
    div []
        [ if List.isEmpty data then
            emptyView
          else
            table []
                [ thead [] (headRows columns)
                , tbody [] (dataRows data callback columns)
                ]
        , appendView data newValue callback
        ]


headRows : Columns record msg -> List (Html msg)
headRows columns =
    let
        headCell : HeaderLabel -> Html msg
        headCell header =
            th [] [ text header ]

        headers : List HeaderLabel
        headers =
            List.map Tuple.first columns
    in
        [ tr [] <| List.map headCell headers ]


dataRows : List record -> ListCallback record msg -> Columns record msg -> List (Html msg)
dataRows data listCallback columns =
    let
        dataRow : Int -> record -> Html msg
        dataRow index record =
            tr [] <| List.map (dataCell record index) renderers

        dataCell record index renderer =
            td [] [ renderer record (\v -> listCallback (ListUtils.replace data index v)) ]

        renderers : List (CellRenderer record msg)
        renderers =
            List.map Tuple.second columns
    in
        List.indexedMap dataRow data


appendView : List record -> record -> ListCallback record msg -> Html msg
appendView list newValue callback =
    button
        [ onClick (callback <| List.append list [ newValue ]) ]
        [ text "+" ]
