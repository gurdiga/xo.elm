module Dosar.Persoana.PersoanaJuridica exposing (Model, Msg, empty, update, view, viewEditForm)

import Html exposing (Html, fieldset, legend, li, map, text, ul)
import Widgets.LargeTextField as LargeTextField
import Widgets.TextField as TextField


type Msg
    = SetDenumire TextField.Msg
    | SetCodFiscal TextField.Msg
    | SetRechiziteBancare LargeTextField.Msg
    | SetAdresa LargeTextField.Msg
    | SetNote LargeTextField.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetDenumire textFieldMsg ->
            { model | denumire = TextField.update textFieldMsg model.denumire }

        SetCodFiscal textFieldMsg ->
            { model | codFiscal = TextField.update textFieldMsg model.codFiscal }

        SetRechiziteBancare largeTextFieldMsg ->
            { model | rechiziteBancare = LargeTextField.update largeTextFieldMsg model.rechiziteBancare }

        SetAdresa largeTextFieldMsg ->
            { model | adresa = LargeTextField.update largeTextFieldMsg model.adresa }

        SetNote largeTextFieldMsg ->
            { model | note = LargeTextField.update largeTextFieldMsg model.note }


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
        , li [] [ LargeTextField.view "Date bancare:" model.rechiziteBancare |> map SetRechiziteBancare ]
        , li [] [ LargeTextField.view "Adresa:" model.adresa |> map SetAdresa ]
        , li [] [ LargeTextField.view "Note:" model.note |> map SetNote ]
        ]
