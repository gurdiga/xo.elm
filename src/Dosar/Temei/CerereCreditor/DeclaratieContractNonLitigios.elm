module Dosar.Temei.CerereCreditor.DeclaratieContractNonLitigios exposing (Model, Msg, initialModel, update, view)

import Dosar.Temei.CerereCreditor.ContractIpoteca as ContractIpoteca
import Html exposing (Html, fieldset, legend, p, text)


type Msg
    = Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        Msg ->
            Debug.todo "Not yet implemented"


type Model
    = Model ContractIpoteca.Model


initialModel : ContractIpoteca.Model -> Model
initialModel contractIpoteca =
    Model contractIpoteca


view : Model -> Html Msg
view (Model model) =
    fieldset []
        [ legend [] [ text "DeclaratieContractNonLitigios" ]
        , p [] [ text "TODO: probably open an pre-filled editable template" ]
        ]
