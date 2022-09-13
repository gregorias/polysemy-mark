{-# LANGUAGE TemplateHaskell #-}

module MarkFile (
  -- * Effect
  MarkFile (..),

  -- * Actions
  readMarkFile,
  writeMarkFile,

  -- * Interpreters
  runMarkFileInMemory,
  runMarkFileOnDisk,
) where

import Polysemy (Embed, Member, Sem, embed, makeSem, reinterpret)
import Polysemy.Input (Input)
import qualified Polysemy.Input as P
import qualified Polysemy.State as PS
import Protolude

data MarkFile m a where
  ReadMarkFile :: MarkFile m Text
  WriteMarkFile :: Text -> MarkFile m ()

makeSem ''MarkFile

runMarkFileInMemory :: Sem (MarkFile : r) a -> Sem (PS.State Text : r) a
runMarkFileInMemory =
  reinterpret
    ( \case
        ReadMarkFile -> PS.get
        WriteMarkFile content -> PS.put content
    )

runMarkFileOnDisk :: (Member (Embed IO) r) => Sem (MarkFile : r) a -> Sem (Input FilePath : r) a
runMarkFileOnDisk =
  reinterpret
    ( \case
        ReadMarkFile -> do
          filename <- P.input
          embed $ readFile filename
        WriteMarkFile content -> do
          filename <- P.input
          embed $ writeFile filename content
    )

data MarkFile m a where
  ReadMarkFile :: MarkFile m UTCTime
  WriteMarkFile :: UTCTime -> MarkFile m ()

makeSem ''MarkFile

runMarkFileInMemory :: Sem (MarkFile : r) a -> Sem (PS.State UTCTime : r) a
runMarkFileInMemory =
  reinterpret
    ( \case
        ReadMarkFile -> PS.get
        WriteMarkFile content -> PS.put content
    )

runMarkFileOnDisk :: (Member (Embed IO) r) => Sem (MarkFile : r) a -> Sem (Input FilePath : r) a
runMarkFileOnDisk =
  reinterpret
    ( \case
        ReadMarkFile -> do
          filename <- P.input
          embed $ readFile filename
        WriteMarkFile content -> do
          filename <- P.input
          embed $ writeFile filename content
    )
