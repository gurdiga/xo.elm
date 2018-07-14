module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunUrmarit exposing (Model, Msg, initialModel, update, view, viewEditForm)

import Html.Styled exposing (Html, fieldset, legend, li, map, text, ul)
import Utils.Money as Money exposing (Currency(MDL), Money(Money))
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
            , li [] [ text ("Valoare:" ++ toString model.valoare) ]
            , li [] [ text ("Note:" ++ model.note) ]
            ]
        ]


viewEditForm : Model -> Html Msg
viewEditForm model =
    ul []
        [ li [] [ TextField.view "Denumire:" model.denumire |> map SetDenumire ]
        , li [] [ MoneyField.view "Valoare:" model.valoare |> map SetValoare ]
        , li [] [ LargeTextField.view "Note:" model.note |> map SetNote ]
        ]


type Msg
    = SetDenumire TextField.Msg
    | SetValoare MoneyField.Msg
    | SetNote LargeTextField.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetDenumire msgTextField ->
            { model | denumire = TextField.update msgTextField model.denumire }

        SetValoare msgMoneyField ->
            { model | valoare = MoneyField.update msgMoneyField model.valoare }

        SetNote msgLargeTextField ->
            { model | note = LargeTextField.update msgLargeTextField model.note }
