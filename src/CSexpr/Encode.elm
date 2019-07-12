module CSexpr.Encode exposing (Encoder, b, encode, list, s)

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

import Bytes exposing (Bytes)
import Bytes.Encode as E


type Encoder
    = Encoder E.Encoder


encode : Encoder -> Bytes
encode (Encoder e) =
    E.encode e


s : String -> Encoder
s str =
    Encoder <|
        E.sequence
            [ E.string <| String.fromInt <| E.getStringWidth str
            , E.string ":"
            , E.string str
            ]


b : Bytes -> Encoder
b bytes =
    Encoder <|
        E.sequence
            [ E.string <| String.fromInt <| Bytes.width bytes
            , E.string ":"
            , E.bytes bytes
            ]


list : List Encoder -> Encoder
list items =
    Encoder <|
        E.sequence
            [ E.string "("
            , E.sequence <| List.map (\(Encoder e) -> e) items
            , E.string ")"
            ]
