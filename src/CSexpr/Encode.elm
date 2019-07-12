module CSexpr.Encode exposing (Encoder, b, encode, list, s)

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
