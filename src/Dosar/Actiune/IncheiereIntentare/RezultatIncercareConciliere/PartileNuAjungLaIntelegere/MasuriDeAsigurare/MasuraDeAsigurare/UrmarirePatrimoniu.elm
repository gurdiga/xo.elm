module Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu exposing (Model, Msg, getValueFromMsg, initialModel, update, view)

import Dosar.Actiune.IncheiereIntentare.RezultatIncercareConciliere.PartileNuAjungLaIntelegere.MasuriDeAsigurare.MasuraDeAsigurare.UrmarirePatrimoniu.BunUrmarit as BunUrmarit exposing (BunUrmarit(BunUrmarit))
import Html.Styled exposing (Html, fieldset, legend, li, text, ul)
import Utils.Money as Money exposing (Currency(EUR, USD), Money(Money))


type alias Model =
    List BunUrmarit


initialModel : Model
initialModel =
    [ BunUrmarit { denumire = "Automobil Ferrari", valoare = Money 400000 EUR, note = "Certo che sì" }
    , BunUrmarit { denumire = "Automobil Porsche", valoare = Money 250000 USD, note = "Yeah!" }
    ]


getValueFromMsg : Msg -> Model
getValueFromMsg msg =
    case msg of
        Msg model ->
            model


view : Model -> Html Msg
view list =
    fieldset []
        [ legend [] [ text "UrmarirePatrimoniu" ]
        , text "TODO: add CRUD UI"
        , ul [] (List.indexedMap itemView list)
        ]


itemView : Int -> BunUrmarit -> Html Msg
itemView i bunUrmarit =
    li [] [ text <| toString bunUrmarit ]


type Msg
    = Msg Model


update : Msg -> Model
update msg =
    case msg of
        Msg model ->
            model
