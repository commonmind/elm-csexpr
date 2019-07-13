module TestMain exposing (suite)

-- Copyright (C) 2019 CommonMind LLC
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU Affero General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Affero General Public License for more details.
--
-- You should have received a copy of the GNU Affero General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.

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
