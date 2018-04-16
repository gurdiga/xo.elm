module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActeEfectuateAnteriorTest exposing (..)

import Expect
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text, tag, attribute, containing)
import Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActeEfectuateAnterior as ActeEfectuateAnterior
import Html.Styled


suite : Test
suite =
    describe "ActeEfectuateAnterior"
        [ test "renders item data" <|
            \_ ->
                let
                    actEfectuatAnterior1 =
                        { copie = { file = { path = "/some/path/some1.file" } }, note = "This is the test file 1" }

                    actEfectuatAnterior2 =
                        { copie = { file = { path = "/some/path/some2.file" } }, note = "This is the test file 2" }
                in
                    [ actEfectuatAnterior1, actEfectuatAnterior2 ]
                        |> ActeEfectuateAnterior.view
                        |> Html.Styled.toUnstyled
                        |> Query.fromHtml
                        |> Query.has
                            [ text actEfectuatAnterior1.note
                            , text actEfectuatAnterior1.copie.file.path
                            , text actEfectuatAnterior2.note
                            , text actEfectuatAnterior2.copie.file.path
                            ]
        ]
