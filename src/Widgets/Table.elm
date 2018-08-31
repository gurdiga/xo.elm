module Widgets.Table exposing (view)

import Html exposing (Html, button, div, table, tbody, td, text, th, thead, tr)
import Utils.MyHtmlEvents exposing (onClick)
import Utils.MyList as MyList


type alias Input record msg =
    { recordList : List record
    , callback : ListCallback record msg
    , columns : Columns record msg
    , emptyView : Html msg
    , empty : record
    }


type alias Columns record msg =
    List ( HeaderLabel, DataCellRenderer record msg )


type alias HeaderLabel =
    String


type alias DataCellRenderer record msg =
    record -> RecordCallback record msg -> List (Html msg)


type alias RecordCallback record msg =
    record -> msg


type alias ListCallback record msg =
    List record -> msg


view : Input record msg -> Html msg
view { recordList, callback, columns, emptyView, empty } =
    div []
        [ if List.isEmpty recordList then
            emptyView
          else
            table []
                [ thead [] (headRows columns)
                , tbody [] (dataRows recordList callback columns)
                ]
        , appendView recordList empty callback
        ]


headRows : Columns record msg -> List (Html msg)
headRows columns =
    let
        headerLabels : List HeaderLabel
        headerLabels =
            List.map Tuple.first columns

        headCell : HeaderLabel -> Html msg
        headCell headerLabel =
            th [] [ text headerLabel ]

        dataHeaderCells =
            List.map headCell headerLabels

        actionColumnCells =
            [ th [] [] ]
    in
    [ tr [] (dataHeaderCells ++ actionColumnCells) ]


dataRows : List record -> ListCallback record msg -> Columns record msg -> List (Html msg)
dataRows recordList listCallback columns =
    let
        dataRow : Int -> record -> Html msg
        dataRow index record =
            tr [] <| dataCells index record ++ actionCells record

        dataCells index record =
            List.map (dataCell index record) dataCellRenderers

        dataCell : Int -> record -> DataCellRenderer record msg -> Html msg
        dataCell index record dataCellRenderer =
            td [] <| dataCellRenderer record (recordCallback index)

        recordCallback : Int -> record -> msg
        recordCallback index record =
            listCallback (MyList.replace recordList index record)

        dataCellRenderers : List (DataCellRenderer record msg)
        dataCellRenderers =
            List.map Tuple.second columns

        actionCells record =
            [ td [] [ button [ onClick (\_ -> delete record) ] [ text "delete" ] ] ]

        delete record =
            listCallback (List.filter ((/=) record) recordList)
    in
    List.indexedMap dataRow recordList


appendView : List record -> record -> ListCallback record msg -> Html msg
appendView list empty callback =
    button
        [ onClick (\_ -> callback <| list ++ [ empty ]) ]
        [ text "+" ]
