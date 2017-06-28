module Dosar.Temei.CerereCreditor exposing (CerereCreditor, newValue, view)

import Html exposing (Html, fieldset, legend, ul, li, label, textarea, text)
import Dosar.Persoană as Persoană exposing (Persoană)
import Dosar.Temei.CerereCreditor.DocumenteContractIpotecă as DocumenteContractIpotecă exposing (DocumenteContractIpotecă)
import Widgets.Fields exposing (largeTextField, checkboxField)


type alias CerereCreditor =
    { creditor : Persoană
    , text : String
    , documenteContractIpotecă : Maybe DocumenteContractIpotecă
    }


newValue : CerereCreditor
newValue =
    { creditor = Persoană.newValue
    , text = ""
    , documenteContractIpotecă = Nothing
    }


view : CerereCreditor -> (CerereCreditor -> msg) -> Html msg
view cerereCreditor callback =
    fieldset []
        [ legend [] [ text "CerereCreditor" ]
        , Persoană.view cerereCreditor.creditor (\v -> callback { cerereCreditor | creditor = v })
        , ul []
            [ li [] [ largeTextField "Text cerere:" cerereCreditor.text (\v -> callback { cerereCreditor | text = v }) ]
            , li []
                [ DocumenteContractIpotecă.view cerereCreditor.documenteContractIpotecă
                    (\v -> callback { cerereCreditor | documenteContractIpotecă = v })
                ]
            ]
        ]
