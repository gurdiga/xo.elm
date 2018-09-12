module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.MijlocBanesc exposing (Model, initialModel, update, view, viewEditForm)

import Html exposing (Html, fieldset, legend, li, map, text, ul)
import Utils.Money as Money exposing (Currency(..), Money(..))
import Widgets.LargeTextField2 as LargeTextField2
import Widgets.MoneyField as MoneyField


type alias Model =
    { valoare : Money
    , note : String
    }


initialModel : Model
initialModel =
    { valoare = Money 0 MDL
    , note = ""
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "MijlocBanesc" ]
        , ul []
            [ li [] [ text ("Valoare:" ++ Money.format model.valoare) ]
            , li [] [ text ("Note:" ++ model.note) ]
            ]
        ]


viewEditForm : Model -> Html Msg
viewEditForm model =
    ul []
        [ li [] [ MoneyField.view "Valoare:" model.valoare |> map SetValoare ]
        , li [] [ LargeTextField2.view "Note:" model.note SetNote ]
        ]


type Msg
    = SetValoare MoneyField.Msg
    | SetNote String


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetValoare msgMoneyField ->
            { model | valoare = MoneyField.update msgMoneyField model.valoare }

        SetNote v ->
            { model | note = v }
