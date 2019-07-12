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
