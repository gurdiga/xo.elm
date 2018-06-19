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
            [ describe "adding items"
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
                , test "the AddItem message updates sets .newItem member on the model" <|
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
                     , describe "the “submit new item” button"
                        [ test "emits the SubmitNewItem message" <|
                            \_ ->
                                rendered
                                    |> Query.find submitNewItemButton
                                    |> Event.simulate Event.click
                                    |> Event.expect (ActeEfectuateAnterior.SubmitNewItem ActEfectuatAnterior.initialModel)
                        , describe "SubmitNewItem message"
                            [ describe "when the item is valid"
                                [ test "appends the item to the item list" <|
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
                        ]
                     , describe "the “cancel” button"
                        [ test "emits the CancelNewItem message" <|
                            \_ ->
                                rendered
                                    |> Query.find cancelNewItemButton
                                    |> Event.simulate Event.click
                                    |> Event.expect ActeEfectuateAnterior.CancelNewItem
                        , test "the CancelNewItem resets the .newItem on the model" <|
                            \_ ->
                                model
                                    |> ActeEfectuateAnterior.update ActeEfectuateAnterior.AddItem
                                    |> ActeEfectuateAnterior.update ActeEfectuateAnterior.CancelNewItem
                                    |> .newItem
                                    |> Expect.equal Nothing
                        ]
                     , describe "new item form changes"
                        (let
                            newFile =
                                "/a/new/file"

                            newNote =
                                "This is a note."
                         in
                         [ describe "the Copie field"
                            [ test "changing emits the SetNewItemFile message" <|
                                \_ ->
                                    rendered
                                        |> Query.find newItemFileField
                                        |> Event.simulate (Event.input newFile)
                                        |> Event.expect (ActeEfectuateAnterior.SetNewItemFile newFile)
                            , test "SetNewItemFile updates the newItem appropriately" <|
                                \_ ->
                                    model
                                        |> ActeEfectuateAnterior.update ActeEfectuateAnterior.AddItem
                                        |> ActeEfectuateAnterior.update (ActeEfectuateAnterior.SetNewItemFile newFile)
                                        |> .newItem
                                        |> Maybe.map (\item -> Expect.equal item.copie.file.path newFile)
                                        |> Maybe.withDefault (Expect.fail ".newItem is unexpectedly Nothing")
                            ]
                         , describe "the Note field"
                            [ test "changing emits the SetNewItemNote message" <|
                                \_ ->
                                    rendered
                                        |> Query.find newItemNoteField
                                        |> Event.simulate (Event.input newNote)
                                        |> Event.expect (ActeEfectuateAnterior.SetNewItemNote newNote)
                            , test "SetNewItemNote updates the newItem appropriately" <|
                                \_ ->
                                    model
                                        |> ActeEfectuateAnterior.update ActeEfectuateAnterior.AddItem
                                        |> ActeEfectuateAnterior.update (ActeEfectuateAnterior.SetNewItemNote newNote)
                                        |> .newItem
                                        |> Maybe.map (\item -> Expect.equal item.note newNote)
                                        |> Maybe.withDefault (Expect.fail ".newItem is unexpectedly Nothing")
                            ]
                         ]
                        )
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
    , containing cancelNewItemButton
    ]


submitNewItemButton : List Selector
submitNewItemButton =
    [ tag "button", id "add-item-submit", attribute (type_ "button") ]


cancelNewItemButton : List Selector
cancelNewItemButton =
    [ tag "button", id "add-item-cancel", attribute (type_ "button") ]


newItemFileField : List Selector
newItemFileField =
    [ tag "input", id "add-item-file", attribute (type_ "file") ]


newItemNoteField : List Selector
newItemNoteField =
    [ tag "textarea", id "add-item-note" ]


render : ActeEfectuateAnterior.Model -> Query.Single ActeEfectuateAnterior.Msg
render model =
    model
        |> ActeEfectuateAnterior.view
        |> Html.Styled.toUnstyled
        |> Query.fromHtml
