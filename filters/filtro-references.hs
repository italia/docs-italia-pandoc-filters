#!/usr/bin/env runhaskell
{-# LANGUAGE OverloadedStrings #-}
import Text.Pandoc.JSON
import Text.Pandoc.Walk
import Text.Pandoc.Definition
import Data.List
import Data.Maybe
import Text.Pandoc.Pretty

toReference :: [String] -> Inline -> Inline
toReference anchors link@(Link _ _ (target, title))
  | hasAnchor = RawInline (Format "rst") (":ref:`" <> title <> target'' <> "`")
  | otherwise = link
  where target'' = if null title
                  then target'
                  else " " <> "<" <> target' <> ">"
        hasAnchor = elem target' anchors
        -- strip the initial `#` from a target
        target' = tail target
toReference _ i = i 

{-

for headers without an id we could calculate an autoId from the
inlines like it's done in `blockToRST (Header ...)` in the rST writer,
we could get the functions from Text.Pandoc.Shared. the problem is
detecting a link pointing to the same header

-}
collectAnchor :: Block -> [String]
collectAnchor (Header _ (name, _, _) _) = [name]
collectAnchor _ = []

addAnchor :: Block -> [Block]
addAnchor b = case collectAnchor b of
  [target] -> [Para [RawInline (Format "rst") (".. _" <> target <> ":")], b]
  _ -> [b]

linksToReferences (Pandoc meta blocks) =
  Pandoc meta (walkBlocks $ walkInlines $ blocks)
  where walkInlines :: [Block] -> [Block]
        walkInlines = walk (toReference anchors)
        walkBlocks :: [Block] -> [Block]
        walkBlocks = walk (concatMap addAnchor)
        anchors :: [String]
        anchors = query collectAnchor blocks

main = toJSONFilter linksToReferences

