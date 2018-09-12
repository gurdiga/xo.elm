module Dosar.Temei.CerereCreditor.InregistrareEvidentaFinanciara exposing (Model, Msg, initialModel, update, view)

import Html exposing (Html, map, td, text, tr)
import Utils.Money as Money exposing (Currency(..), Money(..))
import Utils.MyDate as MyDate
import Widgets.DateField as DateField
import Widgets.LargeTextField2 as LargeTextField2
import Widgets.MoneyField as MoneyField


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
        [ td [] <| [ DateField.view "" model.data |> map SetData ]
        , td [] <| [ MoneyField.view "" model.suma |> map SetSuma ]
        , td [] <| [ LargeTextField2.view "" model.note SetNote ]
        ]


type Msg
    = SetData DateField.Msg
    | SetSuma MoneyField.Msg
    | SetNote String


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetData dateFieldMsg ->
            { model | data = DateField.update dateFieldMsg model.data }

        SetSuma moneyFieldMsg ->
            { model | suma = MoneyField.update moneyFieldMsg model.suma }

        SetNote v ->
            { model | note = v }
