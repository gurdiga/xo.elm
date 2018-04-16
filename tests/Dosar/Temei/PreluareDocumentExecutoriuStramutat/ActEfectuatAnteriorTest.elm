module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActEfectuatAnteriorTest exposing (..)

import Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActEfectuatAnterior as ActEfectuatAnterior
import Expect
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text, tag, attribute, containing)
import Html.Styled
import Test.Html.Event as Event


suite : Test
suite =
    let
        actEfectuatAnterior =
            { copie = { file = { path = "/some/path/some.file" } }, note = "This is the test file" }
    in
        describe "ActEfectuatAnterior"
            [ test "renders item data" <|
                \_ ->
                    renderWithModel actEfectuatAnterior
                        |> Query.has
                            [ text actEfectuatAnterior.note
                            , text actEfectuatAnterior.copie.file.path
                            ]
            , describe "interactions"
                [ describe "adding items"
                    [ test "has an add button" <|
                        \_ ->
                            renderWithModel actEfectuatAnterior
                                |> Query.has
                                    [ tag "button"
                                    , text "Adaugă item"
                                    ]
                    , test "clicking the button" <|
                        \_ ->
                            renderWithModel actEfectuatAnterior
                                |> Query.find
                                    [ tag "button"
                                    , containing [ text "Adaugă item" ]
                                    ]
                                |> Event.simulate Event.click
                                |> Event.expect ActEfectuatAnterior.Set
                    ]
                ]
            ]


renderWithModel : ActEfectuatAnterior.Model -> Query.Single ActEfectuatAnterior.Msg
renderWithModel model =
    ActEfectuatAnterior.view model
        |> Html.Styled.toUnstyled
        |> Query.fromHtml
