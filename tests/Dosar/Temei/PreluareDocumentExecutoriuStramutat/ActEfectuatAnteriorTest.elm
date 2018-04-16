module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActEfectuatAnteriorTest exposing (..)

import Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActEfectuatAnterior as ActEfectuatAnterior
import Expect
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text, tag, attribute, containing)
import Html.Styled.Attributes as Attributes
import Html.Styled
import Test.Html.Event as Event


suite : Test
suite =
    describe "ActEfectuatAnterior"
        [ test "renders item data" <|
            \_ ->
                let
                    model =
                        { copie = { file = { path = "/some/path/some.file" } }, note = "This is the test file" }
                in
                    ActEfectuatAnterior.view model
                        |> Html.Styled.toUnstyled
                        |> Query.fromHtml
                        |> Query.has
                            [ text model.note
                            , text model.copie.file.path
                            ]
        ]
