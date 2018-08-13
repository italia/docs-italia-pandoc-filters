#!/usr/bin/env runhaskell
import Text.Pandoc.JSON

replace []      = []
replace ('”':x) = '"':replace x
replace ('\8220':x) = '"':replace x
replace ('“':x) = '"':replace x
replace ('’':x) = '\'':replace x
replace (c:x)   = c:replace x

f :: Inline -> Inline
f (Str s) = Str (replace s)
f i = i

main = toJSONFilter $ f
