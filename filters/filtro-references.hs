#!/usr/bin/env runhaskell
{-# LANGUAGE OverloadedStrings #-}
import Text.Pandoc.JSON
import Text.Pandoc.Walk
import Text.Pandoc.Definition
import Data.List
import Data.Maybe
import Text.Pandoc.Shared (uniqueIdent)
import Text.Pandoc.Pretty

{-

use this filter with the `--reference-filter` option

-}


toReference :: [String] -> Inline -> Inline
toReference anchors link@(Link _ _ (target, title))
  | hasAnchor = RawInline (Format "rst") (":ref:`" <> title <> target' <> "`")
  | otherwise = link
  where target' = if null title
                  then target
                  else " " <> "<" <> target <> ">"
        hasAnchor = elem target anchors
toReference _ i = i 

-- this follows the logic of `blockToRST (Header ...` in the rST
-- writer in calculating a reference target from an header. in the
-- writer autoId anchors get omitted for links that will be eventually
-- parsed, while here we use this function in order to decide whether
-- to replace a link with a ref or not
collectAnchor :: Block -> [String]
collectAnchor (Header _ (name, _, _) inlines) = [anchor]
  where autoId = uniqueIdent inlines mempty
        anchor | null name = autoId
               | otherwise = name
collectAnchor _ = []

linksToReferences doc@(Pandoc meta blocks) = walk (toReference anchors) doc
  where anchors :: [String]
        anchors = query collectAnchor blocks

main = toJSONFilter linksToReferences

