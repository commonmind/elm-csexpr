module CSexpr exposing (CSexpr(..), encode)

{-| This module provides encoding of canonical S-expressions:

    <https://en.wikipedia.org/wiki/Canonical_S-expressions>

We use these as keys in our storage api and a few other places. They
allow us to marshal structured data into a string, but unlike JSON,
that string is always character-for-character identical if the
structure is the same. This makes it useful as a format for dictionary
keys.

Note that as of right now the implementation is not especially efficient;
avoid passing very large values to `encode`.

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


{-| A canonical s-expression.
-}
type CSexpr
    = List (List CSexpr)
    | Atom String


{-| Convert an s-expression to a string.
-}
encode : CSexpr -> String
encode csexpr =
    case csexpr of
        Atom str ->
            String.fromInt (String.length str) ++ ":" ++ str

        List items ->
            "(" ++ (List.map encode items |> String.concat) ++ ")"
