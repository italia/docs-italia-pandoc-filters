#!/usr/bin/env runhaskell
import Text.Pandoc.JSON
import Text.Pandoc.Definition
import Data.List

r :: Block -> Block
r (Para [Strong i]) = Header 2 nullAttr i
r b           = b

main = toJSONFilter r
