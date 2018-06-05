#!/usr/bin/env runhaskell
import Text.Pandoc.JSON
import Text.Pandoc.Definition
import Data.List
import Text.Read

-- caution! this also removes an integer contained in a table cell. We
-- want to add the table cell case to our test and modify this filter
-- so that it affects only first level paragraphs

r :: Block -> [Block]
r b@(Para [Str s]) = case (readMaybe s :: Maybe Int) of
  Nothing -> [b]
  Just integer -> []
r b = [b]

main = toJSONFilter r
