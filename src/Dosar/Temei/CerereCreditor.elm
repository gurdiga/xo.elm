module Dosar.Temei.CerereCreditor exposing (CerereCreditor, newValue, view)

import Html exposing (Html, h1, fieldset, legend, div, ul, li, text)
import Dosar.Persoana as Persoana exposing (Persoana)
import Dosar.Temei.CerereCreditor.DocumenteContractIpoteca as DocumenteContractIpoteca exposing (DocumenteContractIpoteca)
import RichTextEditor
import MyDate exposing (MyDate)
import Widgets.Fields exposing (dateField)


type CerereCreditor
    = CerereCreditor Data


type alias Data =
    { dataDepunere : MyDate
    , creditor : Persoana
    , html : String
    , documenteContractIpoteca : Maybe DocumenteContractIpoteca
    }


newValue : CerereCreditor
newValue =
    CerereCreditor
        { dataDepunere = MyDate.newValue
        , creditor = Persoana.newValue
        , html = ""
        , documenteContractIpoteca = Nothing
        }


view : CerereCreditor -> (CerereCreditor -> Cmd msg -> Sub msg -> msg) -> Html msg
view cerereCreditor callback =
    let
        (CerereCreditor data) =
            cerereCreditor

        c data =
            callback (CerereCreditor data) Cmd.none Sub.none
    in
        fieldset []
            [ legend [] [ text "CerereCreditor" ]
            , dateField "Data depunerii:" data.dataDepunere (\v -> c { data | dataDepunere = v })
            , Persoana.view data.creditor (\v -> c { data | creditor = v })
            , RichTextEditor.view
                { buttonLabel = "Formează cerere" -- TODO: make it printable
                , content = templateCerere data
                , onOpen = callback cerereCreditor
                , onResponse = (\s -> c { data | html = s })
                }
            , DocumenteContractIpoteca.view data.documenteContractIpoteca
                (\v -> c { data | documenteContractIpoteca = v })
            ]


templateCerere : Data -> List (Html msg)
templateCerere data =
    -- TODO: template?
    [ h1 [] [ text "Cerere de intentare" ]
    , data |> toString |> text
    ]
