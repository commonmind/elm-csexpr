module CSexpr.Encode exposing
    ( Encoder
    , encodeString
    , s, list
    )

{-| Encode Canonical S-expressions as `String`s.

@docs Encoder


# Emitting strings

@docs encodeString


# Assembling encoders

@docs s, list

-}

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
import Bytes.Decode as D
import Bytes.Encode as E


{-| An Encoder is a partially assembled s-expression. Build these with
`s` and `list`, and convert them to strings with`encodeString`.
-}
type Encoder
    = Encoder E.Encoder


{-| Convert an encoder to a string.
-}
encodeString : Encoder -> String
encodeString e =
    let
        bytes =
            encodeBytes e

        len =
            Bytes.width bytes
    in
    case D.decode (D.string len) bytes of
        Just str ->
            str

        Nothing ->
            -- This is impossible; the exposed API can't generate
            -- illegal strings.
            encodeString e


encodeBytes : Encoder -> Bytes
encodeBytes (Encoder e) =
    E.encode e


{-| Encode a string as an atom.
-}
s : String -> Encoder
s str =
    Encoder <|
        E.sequence
            [ E.string <| String.fromInt <| E.getStringWidth str
            , E.string ":"
            , E.string str
            ]


{-| Encode a list.
-}
list : List Encoder -> Encoder
list items =
    Encoder <|
        E.sequence
            [ E.string "("
            , E.sequence <| List.map (\(Encoder e) -> e) items
            , E.string ")"
            ]
