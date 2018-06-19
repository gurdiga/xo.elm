module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActeEfectuateAnterior exposing (Model, Msg(..), initialModel, update, view)

import Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActEfectuatAnterior as ActEfectuatAnterior
import Html.Styled exposing (Html, button, div, fieldset, form, input, label, legend, map, p, text, textarea)
import Html.Styled.Attributes exposing (class, for, id, type_)
import Html.Styled.Events exposing (onClick, onInput)


type Msg
    = Set ActEfectuatAnterior.Msg
    | AddItem
    | CancelNewItem
    | SubmitNewItem ActEfectuatAnterior.Model
    | SetNewItemFile String
    | SetNewItemNote String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Set actEfectuatAnteriorMsg ->
            model

        AddItem ->
            { model | newItem = Just ActEfectuatAnterior.initialModel }

        CancelNewItem ->
            { model | newItem = Nothing }

        SubmitNewItem newItem ->
            { model | items = model.items ++ [ newItem ] }

        SetNewItemFile newFile ->
            case model.newItem of
                Just newItem ->
                    { model | newItem = Just (ActEfectuatAnterior.setFile newItem newFile) }

                -- this should never happen
                Nothing ->
                    model

        SetNewItemNote newNote ->
            case model.newItem of
                Just newItem ->
                    { model | newItem = Just (ActEfectuatAnterior.setNote newItem newNote) }

                -- this should never happen
                Nothing ->
                    model


type alias Model =
    { items : List ActEfectuatAnterior.Model
    , newItem : Maybe ActEfectuatAnterior.Model
    }


type Item
    = Initial ActEfectuatAnterior.Model
    | Valid ActEfectuatAnterior.Model
    | Invalid ActEfectuatAnterior.Model (List ValidationErrorMessage)


type alias ValidationErrorMessage =
    String


initialModel : Model
initialModel =
    { items = []
    , newItem = Nothing
    }


view : Model -> Html Msg
view model =
    fieldset [] <|
        [ legend [] [ text "ActeEfectuateAnterior" ] ]
            ++ List.map itemView model.items
            ++ [ model.newItem
                    |> Maybe.map addForm
                    |> Maybe.withDefault emptySlate
               ]


emptySlate : Html Msg
emptySlate =
    p []
        [ text "No items."
        , button [ id "add-item-button", onClick AddItem ] [ text "Add item" ]
        ]


addForm : ActEfectuatAnterior.Model -> Html Msg
addForm newItem =
    form [ class "add-item" ]
        [ fieldset []
            [ legend [] [ text "Add item" ]
            , label [ for "add-item-file" ] [ text "Document scanat" ]
            , input [ id "add-item-file", type_ "file", onInput SetNewItemFile ] []
            , label [ for "add-item-note" ] [ text "Note" ]
            , textarea [ id "add-item-note", onInput SetNewItemNote ] []
            , div []
                [ button [ id "add-item-submit", onClick (SubmitNewItem newItem), type_ "button" ] [ text "Submit" ]
                , button [ id "add-item-cancel", onClick CancelNewItem, type_ "button" ] [ text "Cancel" ]
                ]
            ]
        ]


itemView : ActEfectuatAnterior.Model -> Html Msg
itemView actEfectuatAnterior =
    ActEfectuatAnterior.view actEfectuatAnterior |> map Set
