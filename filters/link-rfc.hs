#!/usr/bin/env runhaskell
import Text.Pandoc.JSON
import Text.Pandoc.Definition
import Data.List
import Text.ParserCombinators.ReadP
import Data.Char (isDigit, isSpace)

startsWithRFC = do
  string "rfc" +++ string "RFC"
  many (satisfy isSpace)
  many (satisfy isDigit)

isRFC = not . null . readP_to_S startsWithRFC

fromRFCToLink i@(Str s) = case result of
  (head:rest) -> makeLink head
  otherwise   -> i
  where result = reverse $ readP_to_S startsWithRFC s
        isRFC = not $ null result
        makeLink (parsed, rest) = Link nullAttr [Str ("RFC" ++ parsed)] ("https://tools.ietf.org/html/rfc" ++ parsed ++ rest,"")
fromRFCToLink i = i -- do nothing to other kind of inlines

spaceToSpace (Str a:Space:Str b:rest) = spaceToSpace (Str (a++" "++b):rest)
spaceToSpace (i:rest) = i:spaceToSpace rest
spaceToSpace [] = []

t :: [Inline] -> [Inline]
t = map fromRFCToLink . spaceToSpace

main = toJSONFilter t
