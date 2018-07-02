module Dosar.Temei.CerereCreditor.InregistrareEvidentaFinanciara exposing (Model, Msg, initialModel, update, view)

import Dosar.Temei.CerereCreditor.InregistrareEvidentaFinanciara.Css as Css
import Html.Styled exposing (Html, map, td, text, tr)
import Html.Styled.Attributes exposing (css)
import Utils.Money as Money exposing (Currency(MDL), Money(Money))
import Utils.MyDate as MyDate
import Widgets.DateField as DateField
import Widgets.LargeTextField as LargeTextField
import Widgets.MoneyField as MoneyField


type Msg
    = SetData DateField.Msg
    | SetSuma MoneyField.Msg
    | SetNote LargeTextField.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetData dateFieldMsg ->
            { model | data = DateField.update dateFieldMsg model.data }

        SetSuma moneyFieldMsg ->
            { model | suma = MoneyField.update moneyFieldMsg model.suma }

        SetNote largeTextFieldMsg ->
            { model | note = LargeTextField.update largeTextFieldMsg model.note }


type alias Model =
    { data : MyDate.Model
    , suma : Money
    , note : String
    }


initialModel : Model
initialModel =
    { data = MyDate.empty
    , suma = Money 0 MDL
    , note = ""
    }


view : Model -> Html Msg
view model =
    tr []
        [ td [ css [ Css.td ] ] <| [ DateField.view "" model.data |> map SetData ]
        , td [ css [ Css.td ] ] <| [ MoneyField.view "" model.suma |> map SetSuma ]
        , td [ css [ Css.td ] ] <| [ LargeTextField.view "" model.note |> map SetNote ]
        ]
