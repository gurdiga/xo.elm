module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare exposing (Model, Msg, empty, update, view)

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare as MasuraDeAsigurare exposing (Model)
import Html.Styled exposing (Html, button, fieldset, legend, li, map, text, ul)
import Html.Styled.Events exposing (onClick)
import Utils.MyList as MyList


-- import Utils.MyList as MyList


type alias Model =
    List MasuraDeAsigurare.Model


empty : Model
empty =
    []


view : Model -> Html Msg
view list =
    fieldset []
        [ legend [] [ text "MasuriDeAsigurare" ]
        , ul [] (List.map itemView list)
        , button [ onClick (AddItem MasuraDeAsigurare.initialModel) ] [ text "Adaugă" ]
        ]


itemView : MasuraDeAsigurare.Model -> Html Msg
itemView item =
    li []
        [ MasuraDeAsigurare.view item |> map (ReplaceItem item)
        , button
            [ onClick (DeleteItem item) ]
            [ text "Șterge" ]
        ]


type Msg
    = AddItem MasuraDeAsigurare.Model
    | DeleteItem MasuraDeAsigurare.Model
    | ReplaceItem MasuraDeAsigurare.Model MasuraDeAsigurare.Msg


update : Msg -> Model -> Model
update msg list =
    case msg of
        AddItem modelMasuraDeAsigurare ->
            list ++ [ modelMasuraDeAsigurare ]

        DeleteItem msgMasuraDeAsigurare ->
            List.filter ((/=) msgMasuraDeAsigurare) list

        ReplaceItem modelMasuraDeAsigurare msgMasuraDeAsigurare ->
            let
                newModelMasuraDeAsigurare =
                    MasuraDeAsigurare.update msgMasuraDeAsigurare modelMasuraDeAsigurare
            in
            MyList.replaceItem modelMasuraDeAsigurare newModelMasuraDeAsigurare list
