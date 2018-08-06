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

-- the image could be contained in a div with some style attributes,
-- or bare if the user styles only the following paragraph manually
imageAttrs :: Block -> Maybe (Attr, [Inline], String)
imageAttrs (Para [Image attr inlines (loc, _)]) = Just (attr, inlines, loc)
imageAttrs (Div _ [b]) = imageAttrs b
imageAttrs _ = Nothing

captionContents :: Block -> Maybe [Inline]
captionContents (Div (i, c, m) [Para inlines])
  | Just "Caption" <- lookup "custom-style" m = Just (inlines)
  | Just "ImageCaption" <- lookup "custom-style" m = Just (inlines)
  | otherwise = Nothing
captionContents _ = Nothing

altFromInlines :: [Inline] -> String
altFromInlines inlines = "fig:" <> concatMap inlineToString inlines

replaceBlocks :: Block -> Block -> Maybe Block
replaceBlocks imageCandidate captionCandidate = do
  (attr, altInlines, loc) <- imageAttrs imageCandidate
  capInlines <- captionContents captionCandidate
  pure (Para [Image attr capInlines (loc, altFromInlines altInlines)])

replaceTwo :: (Block -> Block -> Maybe Block) -> [Block] -> [Block]
replaceTwo f [] = []
replaceTwo f [b] = [b]
replaceTwo f (b1:b2:rest) = case (f b1 b2) of
  Just replaced -> replaced : replaceTwo f rest -- ahead two steps
  Nothing -> b1 : replaceTwo f (b2:rest)        -- ahead one step

f :: Pandoc -> Pandoc
f (Pandoc m b) = Pandoc m (replaceTwo replaceBlocks b)

main = BL.getContents >>=
    BL.putStr . encode . f . either error id .
    eitherDecode'

