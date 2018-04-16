module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActeEfectuateAnterior exposing (Model, Msg(..), initialModel, view, update)

import Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActEfectuatAnterior as ActEfectuatAnterior
import Html.Styled exposing (Html, fieldset, legend, p, text, map, button, form)
import Html.Styled.Attributes exposing (class)
import Html.Styled.Events exposing (onClick)


type Msg
    = Set ActEfectuatAnterior.Msg
    | AddItem


update : Msg -> Model -> Model
update msg model =
    case msg of
        Set actEfectuatAnteriorMsg ->
            model

        AddItem ->
            { model | itemToAdd = Just ActEfectuatAnterior.initialModel }


type alias Model =
    { items : List ActEfectuatAnterior.Model
    , itemToAdd : Maybe ActEfectuatAnterior.Model
    }


initialModel : Model
initialModel =
    { items = [ ActEfectuatAnterior.initialModel ]
    , itemToAdd = Nothing
    }


view : Model -> Html Msg
view model =
    fieldset [] <|
        legend [] [ text "ActeEfectuateAnterior" ]
            :: (List.map itemView model.items)
            ++ [ button [ onClick AddItem ] [ text "add item" ]
               , model.itemToAdd
                    |> Maybe.map addForm
                    |> Maybe.withDefault (text "")
               ]


addForm : ActEfectuatAnterior.Model -> Html Msg
addForm itemToAdd =
    form [ class "add-item" ] []


itemView : ActEfectuatAnterior.Model -> Html Msg
itemView actEfectuatAnterior =
    ActEfectuatAnterior.view actEfectuatAnterior |> map Set
