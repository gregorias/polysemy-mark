module Main (main) where

import Lib (markFileExperiment0, markFileExperiment1)
import Protolude

main :: IO ()
main = do
  markFileExperiment0
  markFileExperiment1
