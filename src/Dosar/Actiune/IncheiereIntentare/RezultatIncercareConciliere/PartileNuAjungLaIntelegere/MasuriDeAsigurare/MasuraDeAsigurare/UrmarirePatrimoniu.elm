module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu exposing (Model, Msg, initialModel, update, view)

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunUrmarit as BunUrmarit
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.MijlocBanesc as MijlocBanesc
import Html.Styled exposing (Html, button, div, fieldset, legend, li, map, p, text, ul)
import Html.Styled.Events exposing (onClick)
import Utils.MyList as MyList
import Widgets.EditableList as EditableList


type alias Model =
    { bunuriUrmarite : List BunUrmarit.Model
    , bunUrmaritNou : Maybe BunUrmarit.Model
    , bunUrmaritEditat : BunUrmaritEditat
    , mijloaceBanesti : List MijlocBanesc.Model
    , ui : Ui
    }


type alias BunUrmaritEditat =
    Maybe ( Int, BunUrmarit.Model )


setBunUrmaritEditat : BunUrmaritEditat -> Model -> Model
setBunUrmaritEditat bunUrmaritEditat model =
    { model
        | bunUrmaritEditat = bunUrmaritEditat
        , ui = uiSetBunuriUrmariteEditableList (EditableList.setItemToEdit bunUrmaritEditat model.ui.bunuriUrmariteEditableList) model.ui
    }


setBunuriUrmarite : List BunUrmarit.Model -> Model -> Model
setBunuriUrmarite bunuriUrmarite model =
    { model
        | bunuriUrmarite = bunuriUrmarite
        , ui = uiSetBunuriUrmariteEditableList (EditableList.setItems bunuriUrmarite model.ui.bunuriUrmariteEditableList) model.ui
    }


type alias Ui =
    { bunuriUrmariteEditableList : EditableList.Model BunUrmarit.Model
    }


uiSetBunuriUrmariteEditableList : EditableList.Model BunUrmarit.Model -> Ui -> Ui
uiSetBunuriUrmariteEditableList bunuriUrmariteEditableList ui =
    { ui | bunuriUrmariteEditableList = bunuriUrmariteEditableList }


initialModel : Model
initialModel =
    let
        bunuriUrmarite =
            [ BunUrmarit.initialModel ]
    in
    { bunuriUrmarite = bunuriUrmarite
    , bunUrmaritNou = Nothing
    , bunUrmaritEditat = Nothing
    , mijloaceBanesti = []
    , ui =
        { bunuriUrmariteEditableList = EditableList.initialModel bunuriUrmarite Nothing Nothing
        }
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "UrmarirePatrimoniu" ]
        , EditableList.view
            { noItemsView = Just (text "Nu sunt bunuri înregistrate.")
            , viewItem = viewBunUrmarit
            , viewItemAdd = viewBunUrmaritAdd
            , viewItemEdit = viewBunUrmaritEdit
            , viewAddItemButton = button [ onClick BunUrmaritNouAdd ] [ text "Adaugă" ]
            }
            model.ui.bunuriUrmariteEditableList
        , if List.isEmpty model.bunuriUrmarite then
            p [] [ text "Nu sunt bunuri înregistrate." ]
          else
            viewBunuriUrmarite model.bunuriUrmarite
        , model.bunUrmaritNou
            |> Maybe.map viewBunUrmaritAdd
            |> Maybe.withDefault
                (model.bunUrmaritEditat
                    |> Maybe.map viewBunUrmaritEdit
                    |> Maybe.withDefault (button [ onClick BunUrmaritNouAdd ] [ text "Adaugă" ])
                )
        , ul [] (List.indexedMap viewMijlocBanesc model.mijloaceBanesti)
        ]


viewBunuriUrmarite : List BunUrmarit.Model -> Html Msg
viewBunuriUrmarite bunuriUrmarite =
    ul [] (List.indexedMap viewBunUrmarit bunuriUrmarite)


viewBunUrmarit : Int -> BunUrmarit.Model -> Html Msg
viewBunUrmarit i bunUrmarit =
    li []
        [ BunUrmarit.view bunUrmarit |> map BunUrmaritNoop
        , button [ onClick (BunUrmaritEditatInit ( i, bunUrmarit )) ] [ text "Editează" ]
        , button [ onClick (BunUrmaritDelete bunUrmarit) ] [ text "Șterge" ]
        ]


viewBunUrmaritAdd : BunUrmarit.Model -> Html Msg
viewBunUrmaritAdd modelBunUrmarit =
    fieldset []
        [ legend [] [ text "Adaugă bun urmărit" ]
        , BunUrmarit.viewEditForm modelBunUrmarit |> map (BunUrmaritNouSet modelBunUrmarit)
        , button [ onClick (BunUrmaritNouSubmit modelBunUrmarit) ] [ text "Confirmă adăugarea" ]
        , button [ onClick BunUrmaritNouReset ] [ text "Anulează adăugarea" ]
        ]


viewBunUrmaritEdit : ( Int, BunUrmarit.Model ) -> Html Msg
viewBunUrmaritEdit ( i, modelBunUrmarit ) =
    fieldset []
        [ legend [] [ text "Editează bun urmărit" ]
        , BunUrmarit.viewEditForm modelBunUrmarit |> map (BunUrmaritEditatSet ( i, modelBunUrmarit ))
        , button [ onClick (BunUrmaritEditatSubmit ( i, modelBunUrmarit )) ] [ text "Confirmă editarea" ]
        , button [ onClick BunUrmaritEditatReset ] [ text "Anulează editarea" ]
        ]


viewMijlocBanesc : Int -> MijlocBanesc.Model -> Html Msg
viewMijlocBanesc i mijlocBanesc =
    li [] [ text <| toString mijlocBanesc ]


type Msg
    = BunUrmaritNouAdd
    | BunUrmaritNouSet BunUrmarit.Model BunUrmarit.Msg
    | BunUrmaritNouSubmit BunUrmarit.Model
    | BunUrmaritNouReset
    | BunUrmaritEditatInit ( Int, BunUrmarit.Model )
    | BunUrmaritEditatSet ( Int, BunUrmarit.Model ) BunUrmarit.Msg
    | BunUrmaritEditatSubmit ( Int, BunUrmarit.Model )
    | BunUrmaritEditatReset
    | BunUrmaritNoop BunUrmarit.Msg
    | BunUrmaritDelete BunUrmarit.Model
    | Noop BunUrmarit.Model


update : Msg -> Model -> Model
update msg model =
    case msg of
        BunUrmaritNouAdd ->
            { model | bunUrmaritNou = Just BunUrmarit.initialModel }

        BunUrmaritNouSet modelBunUrmarit msgBunUrmarit ->
            { model | bunUrmaritNou = Just (BunUrmarit.update msgBunUrmarit modelBunUrmarit) }

        BunUrmaritNouSubmit modelBunUrmarit ->
            { model | bunUrmaritNou = Nothing, bunuriUrmarite = model.bunuriUrmarite ++ [ modelBunUrmarit ] }

        BunUrmaritNouReset ->
            { model | bunUrmaritNou = Nothing }

        BunUrmaritEditatInit ( i, modelBunUrmarit ) ->
            model
                |> setBunUrmaritEditat (Just ( i, modelBunUrmarit ))

        BunUrmaritEditatSet ( i, modelBunUrmarit ) msgBunUrmarit ->
            model
                |> setBunUrmaritEditat (Just ( i, BunUrmarit.update msgBunUrmarit modelBunUrmarit ))

        BunUrmaritEditatSubmit ( i, modelBunUrmarit ) ->
            model
                |> setBunuriUrmarite (MyList.replace model.bunuriUrmarite i modelBunUrmarit)
                |> setBunUrmaritEditat Nothing

        BunUrmaritEditatReset ->
            model
                |> setBunUrmaritEditat Nothing

        -- TODO: Is this alright?
        BunUrmaritNoop msgBunUrmarit ->
            model

        BunUrmaritDelete modelBunUrmarit ->
            model
                |> setBunuriUrmarite (List.filter ((/=) modelBunUrmarit) model.bunuriUrmarite)
                |> setBunUrmaritEditat Nothing

        Noop modelBunUrmarit ->
            model
