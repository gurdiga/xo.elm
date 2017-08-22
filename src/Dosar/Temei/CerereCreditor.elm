module Dosar.Temei.CerereCreditor exposing (CerereCreditor, empty, view)

import Html exposing (Html, h1, fieldset, legend, div, ul, li, text)
import Dosar.Persoana as Persoana exposing (Persoana)
import Dosar.Temei.CerereCreditor.DocumenteContractIpoteca as DocumenteContractIpoteca exposing (DocumenteContractIpoteca)
import Utils.RichTextEditor as RichTextEditor
import Utils.MyDate as MyDate exposing (MyDate)


type CerereCreditor
    = CerereCreditor Data


type alias Data =
    { dataDepunere : MyDate
    , creditor : Persoana
    , html : String
    , documenteContractIpoteca : Maybe DocumenteContractIpoteca
    }


empty : CerereCreditor
empty =
    CerereCreditor
        { dataDepunere = MyDate.empty
        , creditor = Persoana.empty
        , html = ""
        , documenteContractIpoteca = Nothing
        }


view : CerereCreditor -> (CerereCreditor -> Cmd msg -> Sub msg -> msg) -> Html msg
view ((CerereCreditor data) as cerereCreditor) callback =
    let
        c data =
            callback (CerereCreditor data) Cmd.none Sub.none
    in
        fieldset []
            [ legend [] [ text "CerereCreditor" ]
            , MyDate.view "Data depunerii:" data.dataDepunere (\v -> c { data | dataDepunere = v })
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
