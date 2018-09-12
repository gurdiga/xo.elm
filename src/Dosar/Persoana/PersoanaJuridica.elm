module Dosar.Persoana.PersoanaJuridica exposing (Model, Msg, empty, update, view, viewEditForm)

import Html exposing (Html, fieldset, legend, li, map, text, ul)
import Widgets.LargeTextField as LargeTextField
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
        [ li [] [ TextField.view "Denumire:" model.denumire SetDenumire ]
        , li [] [ TextField.view "Cod fiscal:" model.codFiscal SetCodFiscal ]
        , li [] [ LargeTextField.view "Date bancare:" model.rechiziteBancare SetRechiziteBancare ]
        , li [] [ LargeTextField.view "Adresa:" model.adresa SetAdresa ]
        , li [] [ LargeTextField.view "Note:" model.note SetNote ]
        ]


type Msg
    = SetDenumire String
    | SetCodFiscal String
    | SetRechiziteBancare String
    | SetAdresa String
    | SetNote String


update : Msg -> Model -> Model
update msg model =
    case msg of
        SetDenumire v ->
            { model | denumire = v }

        SetCodFiscal v ->
            { model | codFiscal = v }

        SetRechiziteBancare v ->
            { model | rechiziteBancare = v }

        SetAdresa v ->
            { model | adresa = v }

        SetNote v ->
            { model | note = v }
