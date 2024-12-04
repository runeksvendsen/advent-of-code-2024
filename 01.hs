#! /usr/bin/env cabal
{- cabal:
build-depends: base, text
-}

import qualified Data.Text.Lazy.IO as TIO
import qualified Data.Text.Lazy as LT
import Data.List (sort)
import Text.Read (readMaybe)
import Data.String (fromString)

main =
  TIO.interact
    (LT.pack . show . stdinToStdout . parseStdin)
  where
    stdinToStdout (list1, list2) =
      sum . map (abs . uncurry (-)) $ zip (sort list1) (sort list2)

    parseStdin :: LT.Text -> ([Int], [Int])
    parseStdin = unzip . map parseStdinLineOrFail . LT.lines

    parseStdinLineOrFail stdinLine =
      maybe (error $ "Failed to parse stdin line: " <> show stdinLine) id (parseStdinLineMaybe stdinLine)

    parseStdinLineMaybe :: LT.Text -> Maybe (Int, Int)
    parseStdinLineMaybe stdinLine =
      case LT.splitOn (fromString "   ") stdinLine of
        [numStr1, numStr2] -> do
          num1 <- parseInt numStr1
          num2 <- parseInt numStr2
          pure (num1, num2)
        _ -> Nothing

    parseInt = readMaybe . LT.unpack