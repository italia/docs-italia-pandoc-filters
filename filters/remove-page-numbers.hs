#!/usr/bin/env runhaskell
import Text.Pandoc.JSON
import Text.Pandoc.Definition
import Data.List
import Text.Read

r :: Block -> [Block]
r b@(Para [Str s]) = case (readMaybe s :: Maybe Int) of
  Nothing -> [b]
  Just integer -> []
r b = [b]

main = toJSONFilter r
