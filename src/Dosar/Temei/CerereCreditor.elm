module Dosar.Temei.CerereCreditor exposing (CerereCreditor, newValue, view)

import Html exposing (Html, fieldset, legend, ul, li, label, textarea, text)
import Dosar.Persoana as Persoana exposing (Persoana)
import Dosar.Temei.CerereCreditor.DocumenteContractIpoteca as DocumenteContractIpoteca exposing (DocumenteContractIpoteca)
import Dosar.Temei.CerereCreditor.ContractIpoteca as ContractIpoteca exposing (ContractIpoteca)
import Widgets.Fields exposing (largeTextField, checkboxField)


type alias CerereCreditor =
    { creditor : Persoana
    , text : String
    , documenteContractIpoteca : Maybe DocumenteContractIpoteca
    }


newValue : CerereCreditor
newValue =
    { creditor = Persoana.newValue
    , text = ""
    , documenteContractIpoteca = Just (DocumenteContractIpoteca.newValue ContractIpoteca.newValue)
    }


view : CerereCreditor -> (CerereCreditor -> msg) -> Html msg
view cerereCreditor callback =
    fieldset []
        [ legend [] [ text "CerereCreditor" ]
        , Persoana.view cerereCreditor.creditor (\v -> callback { cerereCreditor | creditor = v })
        , ul []
            [ li [] [ largeTextField "Text cerere:" cerereCreditor.text (\v -> callback { cerereCreditor | text = v }) ]
            , li []
                [ DocumenteContractIpoteca.view cerereCreditor.documenteContractIpoteca
                    (\v -> callback { cerereCreditor | documenteContractIpoteca = v })
                ]
            ]
        ]
