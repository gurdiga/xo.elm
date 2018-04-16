module Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActeEfectuateAnteriorTest exposing (..)

import Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActEfectuatAnterior as ActEfectuatAnterior
import Dosar.Temei.PreluareDocumentExecutoriuStramutat.ActeEfectuateAnterior as ActeEfectuateAnterior
import Expect
import Html.Attributes exposing (for, type_)
import Html.Styled
import Test exposing (..)
import Test.Html.Event as Event
import Test.Html.Query as Query
import Test.Html.Selector exposing (Selector, attribute, classes, containing, id, tag, text)
import Utils.MyList as MyList


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
                            |> Expect.all
                                [ Query.has addItemButton
                                , Query.hasNot addItemForm
                                ]
                , test "the button emits the AddItem message" <|
                    \_ ->
                        render model
                            |> Query.find addItemButton
                            |> Event.simulate Event.click
                            |> Event.expect ActeEfectuateAnterior.AddItem
                , test "the AddItem message updates sets the newItem member on the model" <|
                    \_ ->
                        ActeEfectuateAnterior.update ActeEfectuateAnterior.AddItem model
                            |> .newItem
                            |> Expect.equal (Just ActEfectuatAnterior.initialModel)
                , describe "renders the add form"
                    (let
                        rendered =
                            ActeEfectuateAnterior.update ActeEfectuateAnterior.AddItem model
                                |> render
                     in
                     [ test "controls" <|
                        \_ ->
                            rendered
                                |> Expect.all
                                    [ Query.has addItemForm
                                    , Query.hasNot addItemButton
                                    ]
                     , describe "the submit new item button"
                        [ test "emits the SubmitNewItem message" <|
                            \_ ->
                                rendered
                                    |> Query.find submitNewItemButton
                                    |> Event.simulate Event.click
                                    |> Event.expect (ActeEfectuateAnterior.SubmitNewItem ActEfectuatAnterior.initialModel)
                        , test "the SubmitNewItem appends the given item to the item list" <|
                            \_ ->
                                let
                                    newItem =
                                        ActEfectuatAnterior.initialModel
                                in
                                ActeEfectuateAnterior.update (ActeEfectuateAnterior.SubmitNewItem newItem) model
                                    |> .items
                                    |> MyList.last
                                    |> Expect.equal (Just newItem)
                        ]
                     ]
                    )
                ]
            ]
        ]


addItemButton : List Selector
addItemButton =
    [ tag "button", id "add-item-button" ]


addItemForm : List Selector
addItemForm =
    [ tag "form"
    , classes [ "add-item" ]
    , containing [ tag "label", attribute (for "add-item-file") ]
    , containing [ tag "input", id "add-item-file", attribute (type_ "file") ]
    , containing [ tag "label", attribute (for "add-item-note") ]
    , containing [ tag "textarea", id "add-item-note" ]
    , containing submitNewItemButton
    ]


submitNewItemButton : List Selector
submitNewItemButton =
    [ tag "button", id "add-item-submit", attribute (type_ "button") ]


render : ActeEfectuateAnterior.Model -> Query.Single ActeEfectuateAnterior.Msg
render model =
    model
        |> ActeEfectuateAnterior.view
        |> Html.Styled.toUnstyled
        |> Query.fromHtml
