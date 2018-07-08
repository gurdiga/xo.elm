module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare exposing (Model, Msg, empty, update, view)

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare as MasuraDeAsigurare exposing (Model)
import Html.Styled exposing (Html, button, fieldset, legend, li, map, text, ul)
import Html.Styled.Events exposing (onClick)


-- import Utils.MyList as MyList


type alias Model =
    List MasuraDeAsigurare.Model


empty : Model
empty =
    [ MasuraDeAsigurare.initialModel ]


view : Model -> Html Msg
view list =
    fieldset []
        [ legend [] [ text "MasuriDeAsigurare" ]
        , ul [] (List.indexedMap itemView list)
        , button [ onClick (AddItem MasuraDeAsigurare.initialModel) ] [ text "Adaugă" ]
        ]


itemView : Int -> MasuraDeAsigurare.Model -> Html Msg
itemView i item =
    li []
        [ MasuraDeAsigurare.view item |> map ReplaceItem
        , button
            [ onClick (DeleteItem item) ]
            [ text "Șterge" ]
        ]


type Msg
    = AddItem MasuraDeAsigurare.Model
    | DeleteItem MasuraDeAsigurare.Model
    | ReplaceItem MasuraDeAsigurare.Msg


update : Msg -> Model -> Model
update msg list =
    case msg of
        AddItem modelMasuraDeAsigurare ->
            list ++ [ modelMasuraDeAsigurare ]

        DeleteItem msgMasuraDeAsigurare ->
            List.filter ((/=) msgMasuraDeAsigurare) list

        ReplaceItem mdgMasuraDeAsigurare ->
            list
