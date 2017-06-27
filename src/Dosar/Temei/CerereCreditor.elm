module Dosar.Temei.CerereCreditor exposing (CerereCreditor, newValue, view)

import Html exposing (Html, fieldset, legend, ul, li, label, textarea, text)
import Dosar.Persoană as Persoană exposing (Persoană)
import Dosar.Temei.CerereCreditor.ContractIpotecă as ContractIpotecă exposing (ContractIpotecă)
import Widgets.Fields exposing (largeTextField, checkboxField)


type alias CerereCreditor =
    { creditor : Persoană
    , text : String
    , contractIpotecă : Maybe ContractIpotecă
    }


newValue : CerereCreditor
newValue =
    { creditor = Persoană.newValue
    , text = ""
    , contractIpotecă = Nothing
    }


view : CerereCreditor -> (CerereCreditor -> msg) -> Html msg
view cerereCreditor callback =
    fieldset []
        [ legend [] [ text "CerereCreditor" ]
        , Persoană.view cerereCreditor.creditor (\v -> callback { cerereCreditor | creditor = v })
        , ul []
            [ li [] [ largeTextField "Text cerere:" cerereCreditor.text (\v -> callback { cerereCreditor | text = v }) ]
            , li []
                [ checkboxField "în temeiul contractului de ipotecă"
                    cerereCreditor.contractIpotecă
                    (\v -> callback { cerereCreditor | contractIpotecă = Just ContractIpotecă.newValue })
                ]
            ]
        ]
