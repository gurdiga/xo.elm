module Dosar.Temei.CerereCreditor.InregistrareEvidentaFinanciara exposing (Data, Model, Msg, initialModel, update, view)

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
update msg (Model model) =
    case msg of
        SetData dateFieldMsg ->
            Model { model | data = DateField.update dateFieldMsg model.data }

        SetSuma moneyFieldMsg ->
            Model { model | suma = MoneyField.update moneyFieldMsg model.suma }

        SetNote largeTextFieldMsg ->
            Model { model | note = LargeTextField.update largeTextFieldMsg model.note }


type Model
    = Model Data


type alias Data =
    { data : MyDate.Model
    , suma : Money
    , note : String
    }


initialModel : Model
initialModel =
    Model
        { data = MyDate.empty
        , suma = Money 0 MDL
        , note = ""
        }


view : Model -> Html Msg
view (Model model) =
    tr []
        [ td [ css [ Css.td ] ] <| [ DateField.view "" model.data |> map SetData ]
        , td [ css [ Css.td ] ] <| [ MoneyField.view "" model.suma |> map SetSuma ]
        , td [ css [ Css.td ] ] <| [ LargeTextField.view "" model.note |> map SetNote ]
        ]
