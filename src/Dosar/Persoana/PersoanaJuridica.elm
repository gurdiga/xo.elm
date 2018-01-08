module Dosar.Persoana.PersoanaJuridica exposing (Model, empty, view, Msg, update)

import Html
import Html.Styled exposing (map, fromUnstyled, Html, ul, li)
import Html.Styled.Attributes exposing (css)
import Widgets.TextField as TextField
import Widgets.LargeTextField as LargeTextField
import Dosar.Persoana.PersoanaJuridica.Css as Css


type Msg
    = UpdateDenumire TextField.Msg
    | UpdateCodFiscal TextField.Msg
    | UpdateRechiziteBancare LargeTextField.Msg
    | UpdateAdresa LargeTextField.Msg
    | UpdateNote LargeTextField.Msg


update : Msg -> Model -> Model
update msg (Model model) =
    case msg of
        UpdateDenumire textFieldMsg ->
            Model { model | denumire = TextField.update textFieldMsg model.denumire }

        UpdateCodFiscal textFieldMsg ->
            Model { model | codFiscal = TextField.update textFieldMsg model.codFiscal }

        UpdateRechiziteBancare largeTextFieldMsg ->
            Model { model | rechiziteBancare = LargeTextField.update largeTextFieldMsg model.rechiziteBancare }

        UpdateAdresa largeTextFieldMsg ->
            Model { model | adresa = LargeTextField.update largeTextFieldMsg model.adresa }

        UpdateNote largeTextFieldMsg ->
            Model { model | note = LargeTextField.update largeTextFieldMsg model.note }


type Model
    = Model
        { denumire : String
        , codFiscal : String
        , rechiziteBancare : String
        , adresa : String
        , note : String
        }


empty : Model
empty =
    Model
        { denumire = ""
        , codFiscal = ""
        , rechiziteBancare = ""
        , adresa = ""
        , note = ""
        }


view : Model -> Html Msg
view (Model model) =
    ul [ css [ Css.ul ] ]
        [ li [] [ TextField.view "Denumire:" model.denumire |> Html.map UpdateDenumire |> fromUnstyled ]
        , li [] [ TextField.view "Cod fiscal:" model.codFiscal |> Html.map UpdateCodFiscal |> fromUnstyled ]
        , li [] [ LargeTextField.view "Date bancare:" model.rechiziteBancare |> map UpdateRechiziteBancare ]
        , li [] [ LargeTextField.view "Adresa:" model.adresa |> map UpdateAdresa ]
        , li [] [ LargeTextField.view "Note:" model.note |> map UpdateNote ]
        ]
