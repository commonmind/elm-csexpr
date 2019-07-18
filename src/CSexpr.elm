module CSexpr exposing (CSexpr(..))


type CSexpr
    = List (List CSexpr)
    | Atom String
