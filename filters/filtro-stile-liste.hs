#!/usr/bin/env runhaskell
import Text.Pandoc.JSON
import Text.Pandoc.Definition
import Data.List

{-

"loose lists" are a conventional data model in pandoc, represented as
lists ending with paragraphs. Compact lists are rendered with no empty
lines in between, while items in a loose list are separated by empty
lines

-}

loosen :: Block -> Block
loosen (Plain bs) = Para bs
loosen b = b -- pass other list items through

f :: Block -> Block
f (BulletList items) = BulletList (map (map loosen) items)
f (OrderedList a items) = OrderedList a (map (map loosen) items)
f b = b -- pass other blocks through

main = toJSONFilter f
