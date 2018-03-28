#!/usr/bin/env runhaskell
import Text.Pandoc.JSON
import Text.Pandoc.Definition
import Data.List

{-

this filter's goal is to put some native file on a diet in order to
easily reduce a test case

 -}

diet :: Inline -> [Inline]
diet (Str _)     = []
diet (Space)     = []
diet (SoftBreak) = []
diet i           = [i]

main = toJSONFilter diet
