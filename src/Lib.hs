module Lib (
  markFileExperiment0,
  markFileExperiment1,
) where

import MarkFile (MarkFile, readMarkFile, runMarkFileInMemory, writeMarkFile)
import Polysemy (Embed, Member, Sem, embed, runM)
import qualified Polysemy.State as P
import Protolude

fooWorldExample :: (Member MarkFile r) => Sem r Text
fooWorldExample = do
  foo <- readMarkFile
  writeMarkFile $ foo <> ", World!"
  readMarkFile

hiAndGoodbye :: (Member (Embed IO) r) => Sem r ()
hiAndGoodbye = do
  hello <-
    fooWorldExample
      & runMarkFileInMemory
      & P.evalState "Hello"
  goodbye <-
    fooWorldExample
      & runMarkFileInMemory
      & P.evalState "Goodbye"
  embed @IO $ putStrLn hello
  embed @IO $ putStrLn goodbye

markFileExperiment0 :: IO ()
markFileExperiment0 = do
  output <-
    fooWorldExample
      & runMarkFileInMemory
      & P.evalState "Hello"
      & runM
  putStrLn output

markFileExperiment1 :: IO ()
markFileExperiment1 = hiAndGoodbye & runM
