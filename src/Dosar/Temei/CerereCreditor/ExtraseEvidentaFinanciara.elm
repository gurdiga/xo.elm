module Dosar.Temei.CerereCreditor.ExtraseEvidentaFinanciara exposing (Model, Msg, initialModel, update, view)

import Dosar.Temei.CerereCreditor.InregistrareEvidentaFinanciara as InregistrareEvidentaFinanciara
import Html exposing (Html, button, fieldset, legend, map, p, table, text)
import Html.Events exposing (onClick)
import Utils.MyList as MyList


type Msg
    = SetInregistrareEvidentaFinanciara Int InregistrareEvidentaFinanciara.Msg
    | AddInregistrareEvidentaFinanciara


update : Msg -> Model -> Model
update msg list =
    case msg of
        AddInregistrareEvidentaFinanciara ->
            list ++ [ InregistrareEvidentaFinanciara.initialModel ]

        SetInregistrareEvidentaFinanciara i inregistrareEvidentaFinanciaraMsg ->
            MyList.get i list
                |> Maybe.map (InregistrareEvidentaFinanciara.update inregistrareEvidentaFinanciaraMsg >> MyList.replace list i)
                |> Maybe.withDefault list


type alias Model =
    List InregistrareEvidentaFinanciara.Model


initialModel : Model
initialModel =
    [ InregistrareEvidentaFinanciara.initialModel ]


view : Model -> Html Msg
view list =
    fieldset []
        [ legend [] [ text "ExtraseEvidentaFinanciara" ]
        , if List.isEmpty list then
            emptyView
          else
            entryListView list
        , button [ onClick AddInregistrareEvidentaFinanciara ] [ text "Adaugați" ]
        ]


entryListView : List InregistrareEvidentaFinanciara.Model -> Html Msg
entryListView list =
    list
        |> List.indexedMap (\i v -> InregistrareEvidentaFinanciara.view v |> map (SetInregistrareEvidentaFinanciara i))
        |> table []


emptyView : Html msg
emptyView =
    p [] [ text "Nu sunt înregistrări." ]
