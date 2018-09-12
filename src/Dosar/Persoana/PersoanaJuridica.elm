module Dosar.Persoana.PersoanaJuridica exposing (Model, Msg, empty, update, view, viewEditForm)

import Html exposing (Html, fieldset, legend, li, map, text, ul)
import Widgets.LargeTextField2 as LargeTextField2
import Widgets.TextField as TextField


type alias Model =
    { denumire : String
    , codFiscal : String
    , rechiziteBancare : String
    , adresa : String
    , note : String
    }


empty : Model
empty =
    { denumire = ""
    , codFiscal = ""
    , rechiziteBancare = ""
    , adresa = ""
    , note = ""
    }


view : Model -> Html Msg
view model =
    fieldset []
        [ legend [] [ text "Persoană juridică" ]
        , ul []
            [ li [] [ text ("Denumire: " ++ model.denumire) ]
            , li [] [ text ("Cod fiscal: " ++ model.codFiscal) ]
            , li [] [ text ("Date bancare: " ++ model.rechiziteBancare) ]
            , li [] [ text ("Adresa: " ++ model.adresa) ]
            , li [] [ text ("Note: " ++ model.note) ]
            ]
        ]


viewEditForm : Model -> Html Msg
viewEditForm model =
    ul []
        [ li [] [ TextField.view "Denumire:" model.denumire |> map SetDenumire ]
        , li [] [ TextField.view "Cod fiscal:" model.codFiscal |> map SetCodFiscal ]
        , li [] [ LargeTextField2.view "Date bancare:" model.rechiziteBancare SetRechiziteBancare ]
        , li [] [ LargeTextField2.view "Adresa:" model.adresa SetAdresa ]
        , li [] [ LargeTextField2.view "Note:" model.note SetNote ]
        ]


type Msg
    = SetDenumire TextField.Msg
    | SetCodFiscal TextField.Msg
    | SetRechiziteBancare String
    | SetAdresa String
    | SetNote String


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetDenumire textFieldMsg ->
            { model | denumire = TextField.update textFieldMsg model.denumire }

        SetCodFiscal textFieldMsg ->
            { model | codFiscal = TextField.update textFieldMsg model.codFiscal }

        SetRechiziteBancare v ->
            { model | rechiziteBancare = v }

        SetAdresa v ->
            { model | adresa = v }

        SetNote v ->
            { model | note = v }
