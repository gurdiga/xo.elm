module Dosar.Temei.PreluareDocumentExecutoriuStramutat.CauzaStramutare exposing (CauzaStramutare, empty, view)

import Html exposing (Html, label, text)
import MyMaterial.Select as Select


type
    -- https://workflowy.com/#/b2ffda9470a9
    --
    -- (1) Documentul executoriu va fi strămutat de către executorul
    -- judecătoresc din oficiu sau la cererea creditorului la un alt executor
    -- judecătoresc, stabilit în condiţiile art. 30  din prezentul cod,  în
    -- următoarele cazuri:
    CauzaStramutare
    = -- a) executorul judecătoresc nu mai este competent teritorial, în
      -- conformitate cu art. 30 din prezentul cod;
      IntrerupereCompetenta
    | -- b) documentul executoriu a fost primit cu încălcarea competenţei
      -- teritoriale;
      IncalcareCompetenta
    | --     c) la cererea motivată a creditorului.
      CerereaCreditorului


empty : CauzaStramutare
empty =
    IntrerupereCompetenta


valuesWithLabels : List ( CauzaStramutare, String )
valuesWithLabels =
    [ ( IntrerupereCompetenta, "executorul judecătoresc nu mai este competent teritorial" )
    , ( IncalcareCompetenta, "documentul executoriu a fost primit cu încălcarea competenţei teritoriale" )
    , ( CerereaCreditorului, "cererea motivată a creditorului" )
    ]


view : CauzaStramutare -> (CauzaStramutare -> msg) -> Html msg
view cauzaStramutare callback =
    Select.view
        { labelText = "Cauza strămutării:"
        , valuesWithLabels = valuesWithLabels
        , defaultValue = empty
        , callback = callback
        }
