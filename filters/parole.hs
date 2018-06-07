#!/usr/bin/env runhaskell
import Text.Pandoc.JSON
import Text.Pandoc.Definition
import Data.List


operazioni = (sostituzione ("ANPR" `e` "anpr" `diventa` "Anpr")) `e`
             (sostituzione ("ANAS" `e` "anas" `diventa` "Anas"))


-- primitive

e a b = [a, b]

diventa = (,)

serie [o1, o2] = o1 . o2

sostituzione :: ([String], String) -> Inline -> Inline
sostituzione  configurazione (Str s)
  | elem s insieme = Str sostituto
  | otherwise      = Str s
  where (insieme, sostituto) = configurazione

main = toJSONFilter $ serie operazioni
