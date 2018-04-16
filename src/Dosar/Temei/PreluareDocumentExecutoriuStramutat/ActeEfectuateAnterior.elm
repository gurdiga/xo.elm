module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActeEfectuateAnterior exposing (Model, Msg(..), initialModel, update, view)

import Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActEfectuatAnterior as ActEfectuatAnterior
import Html.Styled exposing (Html, button, fieldset, form, input, label, legend, map, p, text, textarea)
import Html.Styled.Attributes exposing (class, for, id, type_)
import Html.Styled.Events exposing (onClick)


type Msg
    = Set ActEfectuatAnterior.Msg
    | AddItem
    | SubmitNewItem ActEfectuatAnterior.Model


update : Msg -> Model -> Model
update msg model =
    case msg of
        Set actEfectuatAnteriorMsg ->
            model

        AddItem ->
            { model | newItem = Just ActEfectuatAnterior.initialModel }

        SubmitNewItem newItem ->
            { model | items = model.items ++ [ newItem ] }


type alias Model =
    { items : List ActEfectuatAnterior.Model
    , newItem : Maybe ActEfectuatAnterior.Model
    }


initialModel : Model
initialModel =
    { items = [ ActEfectuatAnterior.initialModel ]
    , newItem = Nothing
    }


view : Model -> Html Msg
view model =
    fieldset [] <|
        [ legend [] [ text "ActeEfectuateAnterior" ] ]
            ++ List.map itemView model.items
            ++ [ model.newItem
                    |> Maybe.map addForm
                    |> Maybe.withDefault addButton
               ]


addButton : Html Msg
addButton =
    button [ id "add-item-button", onClick AddItem ] [ text "add item" ]


addForm : ActEfectuatAnterior.Model -> Html Msg
addForm newItem =
    form [ class "add-item" ]
        [ fieldset []
            [ legend [] [ text "Add item" ]
            , label [ for "add-item-file" ] [ text "Document scanat" ]
            , input [ id "add-item-file", type_ "file" ] []
            , label [ for "add-item-note" ] [ text "Note" ]
            , textarea [ id "add-item-note" ] []
            , button [ id "add-item-submit", onClick (SubmitNewItem newItem), type_ "button" ] [ text "Submit" ]
            ]
        ]


itemView : ActEfectuatAnterior.Model -> Html Msg
itemView actEfectuatAnterior =
    ActEfectuatAnterior.view actEfectuatAnterior |> map Set
