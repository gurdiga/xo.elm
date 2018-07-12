module Utils.MyListTest exposing (..)

import Expect
import Test exposing (..)
import Utils.MyList as MyList


type Tag a
    = Tag a


suite : Test
suite =
    describe "MyList"
        [ describe "replaceItem"
            [ test "replaces the given item with a new one: numbers" <|
                \_ ->
                    Expect.equal (MyList.replaceItem 1 101 [ 1, 2, 3 ]) [ 101, 2, 3 ]
            , test "replaces the given item with a new one: records" <|
                \_ ->
                    Expect.equal (MyList.replaceItem { v = 1 } { v = 101 } [ { v = 1 }, { v = 2 }, { v = 3 } ]) [ { v = 101 }, { v = 2 }, { v = 3 } ]
            , test "replaces the given item with a new one: tagged values" <|
                \_ ->
                    Expect.equal (MyList.replaceItem (Tag 1) (Tag 101) [ Tag 1, Tag 2, Tag 3 ]) [ Tag 101, Tag 2, Tag 3 ]
            , test "replaces the given item with a new one: tagged records" <|
                \_ ->
                    Expect.equal (MyList.replaceItem (Tag { v = 1 }) (Tag { v = 101 }) [ Tag { v = 1 }, Tag { v = 2 }, Tag { v = 3 } ]) [ Tag { v = 101 }, Tag { v = 2 }, Tag { v = 3 } ]
            ]
        ]
