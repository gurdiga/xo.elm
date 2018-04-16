module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActeEfectuateAnteriorTest exposing (..)

import Expect
import Test exposing (..)
import Test.Html.Query as Query
import Test.Html.Selector exposing (text, tag, attribute, containing)
import Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActeEfectuateAnterior as ActeEfectuateAnterior
import Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActEfectuatAnterior as ActEfectuatAnterior
import Test.Html.Event as Event
import Html.Styled


suite : Test
suite =
    let
        model =
            { items = [ actEfectuatAnterior1, actEfectuatAnterior2 ]
            , itemToAdd = Nothing
            }

        actEfectuatAnterior1 =
            { copie = { file = { path = "/some/path/some1.file" } }, note = "This is the test file 1" }

        actEfectuatAnterior2 =
            { copie = { file = { path = "/some/path/some2.file" } }, note = "This is the test file 2" }
    in
        describe "ActeEfectuateAnterior"
            [ test "renders item data" <|
                \_ ->
                    render model
                        |> Query.has
                            [ text actEfectuatAnterior1.note
                            , text actEfectuatAnterior1.copie.file.path
                            , text actEfectuatAnterior2.note
                            , text actEfectuatAnterior2.copie.file.path
                            ]
            , describe "interactions"
                [ describe "addint items"
                    [ test "has an add button" <|
                        \_ ->
                            render model
                                |> Query.has
                                    [ tag "button"
                                    , text "add item"
                                    ]
                    , test "the button emits the appropriate message" <|
                        \_ ->
                            render model
                                |> Query.find
                                    [ tag "button"
                                    , containing [ text "add item" ]
                                    ]
                                |> Event.simulate Event.click
                                |> Event.expect ActeEfectuateAnterior.AddItem
                    , test "the message updates the model appropriatelly" <|
                        \_ ->
                            ActeEfectuateAnterior.update ActeEfectuateAnterior.AddItem model
                                |> .itemToAdd
                                |> Expect.equal (Just ActEfectuatAnterior.initialModel)
                    ]
                ]
            ]


render : ActeEfectuateAnterior.Model -> Query.Single ActeEfectuateAnterior.Msg
render model =
    model
        |> ActeEfectuateAnterior.view
        |> Html.Styled.toUnstyled
        |> Query.fromHtml
