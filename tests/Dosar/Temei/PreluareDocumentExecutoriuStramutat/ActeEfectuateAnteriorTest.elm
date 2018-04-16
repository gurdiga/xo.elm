module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActeEfectuateAnteriorTest exposing (..)

import Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActEfectuatAnterior as ActEfectuatAnterior
import Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActeEfectuateAnterior as ActeEfectuateAnterior
import Expect
import Html.Attributes exposing (for, type_)
import Html.Styled
import Test exposing (..)
import Test.Html.Event as Event
import Test.Html.Query as Query
import Test.Html.Selector exposing (attribute, classes, containing, id, tag, text)


suite : Test
suite =
    let
        model =
            { items = [ actEfectuatAnterior1, actEfectuatAnterior2 ]
            , newItem = Nothing
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
                                , id "add-item-button"
                                ]
                            |> Event.simulate Event.click
                            |> Event.expect ActeEfectuateAnterior.AddItem
                , test "the message updates the model appropriatelly" <|
                    \_ ->
                        ActeEfectuateAnterior.update ActeEfectuateAnterior.AddItem model
                            |> .newItem
                            |> Expect.equal (Just ActEfectuatAnterior.initialModel)
                , test "renders the add form" <|
                    \_ ->
                        ActeEfectuateAnterior.update ActeEfectuateAnterior.AddItem model
                            |> render
                            |> Expect.all
                                [ Query.has
                                    [ tag "form"
                                    , classes [ "add-item" ]
                                    , containing [ tag "label", attribute (for "add-item-file") ]
                                    , containing [ tag "input", id "add-item-file", attribute (type_ "file") ]
                                    , containing [ tag "label", attribute (for "add-item-note") ]
                                    , containing [ tag "textarea", id "add-item-note" ]
                                    , containing [ tag "button", id "add-item-submit" ]
                                    ]
                                , Query.hasNot [ tag "button", id "add-item-button" ]
                                ]
                ]
            ]
        ]


render : ActeEfectuateAnterior.Model -> Query.Single ActeEfectuateAnterior.Msg
render model =
    model
        |> ActeEfectuateAnterior.view
        |> Html.Styled.toUnstyled
        |> Query.fromHtml
