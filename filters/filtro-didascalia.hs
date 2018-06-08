#!/usr/bin/env runhaskell
import Text.Pandoc.JSON
import Text.Pandoc.Walk
import qualified Data.ByteString.Lazy as BL
import Text.Pandoc.Definition (Inline(..))
import Data.Aeson
import Data.List
import Data.Monoid ((<>))
import GHC.Integer (absInteger)


inlineToString :: Inline -> String
inlineToString (Str s) = s
inlineToString Space = " "
inlineToString _ = ""

g :: Block -> Block -> Maybe Block
g (Para [Image imageAttrs altInlines (loc, _)]) (Div (i, c, m) [Para captionInlines])
  | Just "Caption" <- lookup "custom-style" m = Just (Para [Image imageAttrs captionInlines (loc, figAlt)])
  where figAlt = "fig:" <> concatMap inlineToString altInlines
g _ _ = Nothing

processTwo :: (Block -> Block -> Maybe Block) -> [Block] -> [Block]
processTwo f [] = []
processTwo f [b] = [b]
processTwo f (b1:b2:rest) = case (f b1 b2) of
  Just processed -> processed : processTwo f rest -- ahead two steps
  Nothing -> b1 : processTwo f (b2:rest) -- ahead one step

f :: Pandoc -> Pandoc
f (Pandoc m b) = Pandoc m (processTwo g b)

main = BL.getContents >>=
    BL.putStr . encode . f . either error id .
    eitherDecode'

