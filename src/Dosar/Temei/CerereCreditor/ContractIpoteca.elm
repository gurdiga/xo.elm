module Dosar.Temei.CerereCreditor.ContractIpoteca exposing (Model, Msg, empty, update, view)

import Html.Styled exposing (Html, fieldset, legend, li, map, text, ul)
import Utils.Money as Money exposing (Currency(..), Money(..))
import Widgets.LargeTextField as LargeTextField
import Widgets.MoneyField as MoneyField


type Msg
    = SetObiect LargeTextField.Msg
    | SetValoareBunDePiata MoneyField.Msg
    | SetValoareBunDeInlocuire MoneyField.Msg
    | SetValoareDeBazaCreanta MoneyField.Msg
    | SetNote LargeTextField.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetObiect largeTextFieldMsg ->
            { model | obiect = LargeTextField.update largeTextFieldMsg model.obiect }

        SetValoareBunDePiata moneyFieldMsg ->
            { model | valoareBunDePiata = MoneyField.update moneyFieldMsg model.valoareBunDePiata }

        SetValoareBunDeInlocuire moneyFieldMsg ->
            { model | valoareBunDeInlocuire = MoneyField.update moneyFieldMsg model.valoareBunDeInlocuire }

        SetValoareDeBazaCreanta moneyFieldMsg ->
            { model | valoareDeBazaCreanta = MoneyField.update moneyFieldMsg model.valoareDeBazaCreanta }

        SetNote largeTextFieldMsg ->
            { model | note = LargeTextField.update largeTextFieldMsg model.note }


type alias Model =
    { obiect : String
    , valoareBunDePiata : Money
    , valoareBunDeInlocuire : Money
    , valoareDeBazaCreanta : Money
    , note : String
    }


empty : Model
empty =
    { obiect = ""
    , valoareBunDePiata = Money 0 MDL
    , valoareBunDeInlocuire = Money 0 MDL
    , valoareDeBazaCreanta = Money 0 MDL
    , note = ""
    }


view : Model -> Html Msg
view contractIpoteca =
    fieldset []
        [ legend [] [ text "ContractIpoteca" ]
        , LargeTextField.view "Obiectul ipotecii:" contractIpoteca.obiect |> map SetObiect
        , MoneyField.view "Valoarea de piaţa a bunului:" contractIpoteca.valoareBunDePiata |> map SetValoareBunDePiata
        , MoneyField.view "Valoarea de inlocuire a bunului:" contractIpoteca.valoareBunDeInlocuire |> map SetValoareBunDeInlocuire
        , MoneyField.view "Valoarea de baza a creanţei garantate:" contractIpoteca.valoareDeBazaCreanta |> map SetValoareDeBazaCreanta
        , LargeTextField.view "Note:" contractIpoteca.note |> map SetNote
        ]
