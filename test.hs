#!/usr/bin/env stack
-- stack --resolver lts-10.10 script --package turtle --package pandoc --package text --package foldl
{-# LANGUAGE OverloadedStrings #-}
import Turtle
import Control.Applicative
import Data.Text (pack, empty)
import Control.Foldl hiding (map)
import Data.Maybe (fromJust)

toTestDir p = "tests" </> (filename $ dropExtension p)

tempFile = "/tmp/pandoc-filter-automated-test.native"

main = view testAll

testAll :: Shell Text
testAll = do
  filterName <- ls "filters"
  testFilter filterName

echoText :: Text -> Shell ()
echoText = echo . fromJust . textToLine

showWorkingDir :: Shell ()
showWorkingDir = do
  d <- pwd
  echoText $ format fp d

inDir :: Turtle.FilePath -> Shell a -> Shell a
inDir d s = do
  old <- pwd
  cd d
  showWorkingDir
  res <- s
  cd old
  showWorkingDir
  pure res

testFilter :: Turtle.FilePath -> Shell Text
testFilter f = do
  exists <- testpath (toTestDir f)
  if exists
    then inDir (toTestDir f) (testNumber f) 
    else pure $ format ("no tests for "%fp) f

testNumber :: Turtle.FilePath -> Shell Text
testNumber f = do
  number <- ls "."
  inDir number (
    do
      --echo $ fromJust $ textToLine (pandoc f)
      shell (pandoc f) Control.Applicative.empty
      exit <- shell ("diff out.native " <> tempFile) Control.Applicative.empty
      pure $ report exit f number)

pandoc f = format ("pandoc in.native -o "%s%" --filter=../../../"%fp) tempFile f

report :: ExitCode -> Turtle.FilePath -> Turtle.FilePath -> Text
report e = format (fp % " " % fp % outcome e)
  where outcome ExitSuccess = " success"
        outcome (ExitFailure _) = " failure"

