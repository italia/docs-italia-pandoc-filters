#!/usr/bin/env stack
-- stack --resolver lts-12.0 script --package turtle --package pandoc --package text --package foldl --package system-filepath --profile
{-# LANGUAGE OverloadedStrings #-}
import Turtle
import Control.Applicative
import Data.Text (pack, unpack, empty)
import Control.Foldl hiding (map)
import Data.Maybe (fromJust)
import Filesystem.Path (addExtension)


tempFile = "/tmp/pandoc-filter-automated-test.native"

-- | get the filter to be used for tests in a dir
--
-- >>> filterFromDir (FilePath "tests/filter/3")
-- "../../../filter.hs"
filterFromDir p = filters <> name <> ".hs"
  where name = pack $ init $ unpack $ format fp $ splitDirectories p !! 1
        filters = "../../../filters/"

report :: ExitCode -> Turtle.FilePath -> Text
report e = format (fp % " " % outcome e)
  where outcome ExitSuccess = " success"
        outcome (ExitFailure _) = " failure"

pandoc d = format ("pandoc in.native -o " % s % " --filter=" % s) tempFile f
  where f = filterFromDir d

echoText :: Text -> Shell ()
echoText = if False then echo . fromJust . textToLine else const (pure ())

showWorkingDir :: Shell ()
showWorkingDir = do
  d <- pwd
  echoText $ format fp d

inDir :: Turtle.FilePath -> Shell a -> Shell a
inDir dir f = do
  old <- pwd
  cd dir
  showWorkingDir
  res <- f
  cd old
  pure res

collectTests = join $ ls <$> ls "tests"

testAndReport dir = do
  shell (pandoc dir) Control.Applicative.empty
  exit <- shell ("diff out.native " <> tempFile) Control.Applicative.empty
  pure $ report exit dir

testAll = do
  showWorkingDir
  dir <- collectTests
  -- the following gets executed multiple times for the monadic composition
  inDir dir (testAndReport dir)

main = view testAll
