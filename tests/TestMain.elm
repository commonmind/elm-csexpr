module TestMain exposing (suite)

import CSexpr.Encode as E
import Expect
import Test exposing (..)


suite : Test
suite =
    describe "Tests for CSexpr.Encode"
        ([ ( "()", E.list [] )
         , ( "(1:a2:bc)", E.list [ E.s "a", E.s "bc" ] )
         , ( "(()4:four(2:ab3:cde))"
           , E.list
                [ E.list []
                , E.s "four"
                , E.list [ E.s "ab", E.s "cde" ]
                ]
           )
         ]
            |> List.map
                (\( text, sexpr ) ->
                    test ("encode " ++ Debug.toString sexpr ++ " == " ++ text) <|
                        \_ ->
                            Expect.equal text (E.encodeString sexpr)
                )
        )
