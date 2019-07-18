module CSexpr.Decode exposing (decodeString)

import Bytes.Decode as D
import Bytes.Encode as E
import CSexpr exposing (CSexpr(..))


decodeString : String -> Maybe CSexpr
decodeString str =
    E.encode (E.string str)
        |> D.decode decoder


decoder : D.Decoder CSexpr
decoder =
    D.unsignedInt8
        |> D.andThen
            (\codePoint -> sexpr (Char.fromCode codePoint) codePoint)


listDecoder : List CSexpr -> D.Decoder CSexpr
listDecoder accum =
    D.unsignedInt8
        |> D.andThen
            (\codePoint ->
                let
                    char =
                        Char.fromCode codePoint
                in
                if char == ')' then
                    D.succeed (List <| List.reverse accum)

                else
                    sexpr char codePoint
                        |> D.andThen (\x -> listDecoder (x :: accum))
            )


sexpr : Char -> Int -> D.Decoder CSexpr
sexpr char codePoint =
    if char == '(' then
        listDecoder []

    else if Char.isDigit char then
        atomDecoder (codePoint - Char.toCode '0')

    else
        D.fail


atomDecoder len =
    D.unsignedInt8
        |> D.andThen
            (\cp ->
                let
                    char =
                        Char.fromCode cp
                in
                if char == ':' then
                    D.map Atom (D.string len)

                else if len == 0 then
                    -- Length can't start with a leading zero unless
                    -- the whole value is zero, so we should have gotten
                    -- a ':' here.
                    D.fail

                else if Char.isDigit char then
                    atomDecoder (len * 10 + (cp - Char.toCode '0'))

                else
                    D.fail
            )
