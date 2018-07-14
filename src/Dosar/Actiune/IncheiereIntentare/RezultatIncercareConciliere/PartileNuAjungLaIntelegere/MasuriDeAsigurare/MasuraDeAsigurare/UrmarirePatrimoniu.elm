module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu exposing (Model, Msg, initialModel, update, view)

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunUrmarit as BunUrmarit
import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.MijlocBanesc as MijlocBanesc
import Html.Styled exposing (Html, button, div, fieldset, legend, li, map, p, text, ul)
import Html.Styled.Events exposing (onClick)
import Utils.MyList as MyList


type alias Model =
    { bunuri : List BunUrmarit.Model
    , bunUrmaritNou : Maybe BunUrmarit.Model
    , bunUrmaritEditat : Maybe ( Int, BunUrmarit.Model )
    , mijloaceBanesti : List MijlocBanesc.Model
    }


initialModel : Model
initialModel =
    { bunuri = []
    , bunUrmaritNou = Nothing
    , bunUrmaritEditat = Nothing
    , mijloaceBanesti = []
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "UrmarirePatrimoniu" ]
        , if List.isEmpty model.bunuri then
            p [] [ text "Nu sunt bunuri înregistrate." ]
          else
            viewBunuriUrmarite model.bunuri
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
viewBunuriUrmarite bunuri =
    ul [] (List.indexedMap viewBunUrmarit bunuri)


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


update : Msg -> Model -> Model
update msg model =
    case msg of
        BunUrmaritNouAdd ->
            { model | bunUrmaritNou = Just BunUrmarit.initialModel }

        BunUrmaritNouSet modelBunUrmarit msgBunUrmarit ->
            { model | bunUrmaritNou = Just (BunUrmarit.update msgBunUrmarit modelBunUrmarit) }

        BunUrmaritNouSubmit modelBunUrmarit ->
            { model | bunUrmaritNou = Nothing, bunuri = model.bunuri ++ [ modelBunUrmarit ] }

        BunUrmaritNouReset ->
            { model | bunUrmaritNou = Nothing }

        BunUrmaritEditatInit ( i, modelBunUrmarit ) ->
            { model | bunUrmaritEditat = Just ( i, modelBunUrmarit ) }

        BunUrmaritEditatSet ( i, modelBunUrmarit ) msgBunUrmarit ->
            { model | bunUrmaritEditat = Just ( i, BunUrmarit.update msgBunUrmarit modelBunUrmarit ) }

        BunUrmaritEditatSubmit ( i, modelBunUrmarit ) ->
            let
                newBunuri =
                    MyList.replace model.bunuri i modelBunUrmarit
            in
            { model | bunUrmaritEditat = Nothing, bunuri = newBunuri }

        BunUrmaritEditatReset ->
            { model | bunUrmaritEditat = Nothing }

        BunUrmaritNoop msgBunUrmarit ->
            model

        BunUrmaritDelete modelBunUrmarit ->
            { model | bunuri = List.filter ((/=) modelBunUrmarit) model.bunuri }
