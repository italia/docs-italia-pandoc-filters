{-# LANGUAGE OverloadedStrings #-}
module Main where

import Text.Pandoc
import Text.Pandoc.JSON
import Text.Pandoc.Walk (query, walk)
import qualified Data.Text.IO as T
import Data.Monoid ((<>))
import Options.Applicative
import Control.Monad (sequence_, join)
import Data.Either (fromRight)
import Data.List (intercalate)
import System.Directory (createDirectoryIfMissing)



main = do
  c <- T.getContents
  c' <- (onBody f . fromRight (Pandoc nullMeta []) . readJSON def) c
  (T.putStr . writeJSON def) c'

onBody :: ([Block] -> IO [Block]) -> Pandoc -> IO Pandoc
onBody f (Pandoc m b) = do
  b' <- f b
  pure (Pandoc m b')

f :: [Block] -> IO [Block]
f d = do
  createDirectoryIfMissing True "index"  
  writeSections d
  pure (makeIndex d)

writeSections :: [Block] -> IO ()
writeSections = sequence_ . map writeSection . snd . breakSections

writeSection :: [Block] -> IO ()
writeSection s =
  let path = getPath $ head s
  in do
    (Right contents) <- runIO (writeRST def (Pandoc nullMeta s))
    T.writeFile path contents

makeIndex :: [Block] -> [Block]
makeIndex b = getIntro b <> [tableOfContents]
  where tableOfContents = tocTree 2 $ map getPath $ filter (isHeading 2) b

getIntro = join . fst . breakSections

breakSections body = (intro, sections)
  where intro = take 1 broken
        sections = drop 1 broken
        broken = multiBreak (isHeading 2) body

-- | Multiple version of break, like a `split` that keeps the delimiter
-- >>> multiBreak (==' ') "bla bla bla b"
-- ["bla"," bla"," bla"," b"]
multiBreak :: (a -> Bool) -> [a] -> [[a]]
multiBreak p [] = []
multiBreak p l@(h:t)
  | p h       = (h : t1) : multiBreak p t2
  | otherwise = l1 : multiBreak p l2
  where (t1, t2) = break p t
        (l1, l2) = break p l

{-

.. toctree::
   :maxdepth: 2
   :caption: Indice dei contenuti

   index/che-cos-e-docs-italia.rst
   index/starter-kit.rst

-}
tocTree :: Int -> [String] -> Block
tocTree depth paths = RawBlock "rst" $
           ".. toctree::" <>
           "\n  :maxdepth: " <> show depth <>
           "\n  :caption: Indice dei contenuti" <>
           "\n" <>
           concatMap (\x -> "\n  "<>x) paths

-- | get the path corresponding to some heading
-- >>> getPath (Header 2 ("", [], []) [Str "my section accénted"])
-- "index/my-section-accénted.rst"
getPath :: Block -> String
getPath (Header _  _ i) = "index/" <> (foldl j "" $ walk simplify' i) <> ".rst"
  where j s1 (Str s2) = s1 <> s2

simplify' = concatMap simplify

simplify :: Inline -> [Inline]
simplify (Emph i) = i
simplify (Strong i) = i
simplify Space = [Str "-"]
simplify i = [i]

isHeading :: Int -> Block -> Bool
isHeading a (Header b _ _) = a == b
isHeading _ _ = False
