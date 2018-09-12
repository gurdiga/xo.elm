module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunUrmarit exposing (Model, Msg, initialModel, update, view, viewEditForm)

import Html exposing (Html, fieldset, legend, li, map, text, ul)
import Utils.Money as Money exposing (Currency(..), Money(..))
import Widgets.LargeTextField as LargeTextField
import Widgets.MoneyField as MoneyField
import Widgets.TextField as TextField


type alias Model =
    { denumire : String
    , valoare : Money
    , note : String
    }


initialModel : Model
initialModel =
    { denumire = ""
    , valoare = Money 0 MDL
    , note = ""
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "BunUrmarit" ]
        , ul []
            [ li [] [ text ("Denumire:" ++ model.denumire) ]
            , li [] [ text ("Valoare:" ++ Money.format model.valoare) ]
            , li [] [ text ("Note:" ++ model.note) ]
            ]
        ]


viewEditForm : Model -> Html Msg
viewEditForm model =
    ul []
        [ li [] [ TextField.view "Denumire:" model.denumire SetDenumire ]
        , li [] [ MoneyField.view "Valoare:" model.valoare |> map SetValoare ]
        , li [] [ LargeTextField.view "Note:" model.note SetNote ]
        ]


type Msg
    = SetDenumire String
    | SetValoare MoneyField.Msg
    | SetNote String


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetDenumire v ->
            { model | denumire = v }

        SetValoare msgMoneyField ->
            { model | valoare = MoneyField.update msgMoneyField model.valoare }

        SetNote v ->
            { model | note = v }
