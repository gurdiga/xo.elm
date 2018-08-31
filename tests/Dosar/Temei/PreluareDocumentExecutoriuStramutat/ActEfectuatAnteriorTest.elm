module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActEfectuatAnteriorTest exposing (..)

import Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActEfectuatAnterior as ActEfectuatAnterior
import Expect
import Html
import Html.Attributes as Attributes
import Test exposing (..)
import Test.Html.Event as Event
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, containing, tag, text)


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
                    |> Query.fromHtml
                    |> Query.has
                        [ text model.note
                        , text model.copie.file.path
                        ]
        ]
