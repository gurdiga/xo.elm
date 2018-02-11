module Dosar.Temei.CerereCreditor.ExtraseEvidentaFinanciara exposing (Model, Msg, initialModel, update, view)

import Dosar.Temei.CerereCreditor.InregistrareEvidentaFinanciara as InregistrareEvidentaFinanciara
import Html.Styled exposing (Html, button, fieldset, legend, map, p, table, text)
import Html.Styled.Events exposing (onClick)
import Utils.MyList as MyList


-- TODO: Continue here


type Msg
    = SetInregistrareEvidentaFinanciara Int InregistrareEvidentaFinanciara.Msg
    | AddInregistrareEvidentaFinanciara


update : Msg -> Model -> Model
update msg (Model list) =
    case msg of
        AddInregistrareEvidentaFinanciara ->
            Model (list ++ [ InregistrareEvidentaFinanciara.empty ])

        SetInregistrareEvidentaFinanciara i inregistrareEvidentaFinanciaraMsg ->
            let
                x =
                    MyList.get list i
            in
            case x of
                Just v ->
                    InregistrareEvidentaFinanciara.update inregistrareEvidentaFinanciaraMsg v
                        |> MyList.replace list i
                        |> Model

                Nothing ->
                    Model list


type Model
    = Model (List InregistrareEvidentaFinanciara.Model)


initialModel : Model
initialModel =
    Model []


view : Model -> Html Msg
view (Model list) =
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
