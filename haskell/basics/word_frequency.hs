-- word_frequency.hs: Word frequencies of a fixed sentence
--
-- Description:
-- Count the words of a fixed text, most frequent first and alphabetically within a tie.
--
-- Part of the basics cross-language exercise set: the input is fixed in the
-- source, and the output is the same as that of the same exercise in every
-- other language. The exercises are specified in README.md at the
-- repository root.
--
-- Author: id774 (More info: https://id774.net)
-- Source Code: https://github.com/id774/sandbox
-- License: The GPL version 3, or LGPL version 3 (Dual License).
-- Contact: idnanashi@gmail.com
--
-- Usage:
--     runghc word_frequency.hs
--
-- Requirements:
-- - GHC 7.10 or later (runghc), with the containers package that ships
--   with GHC
-- - No third-party package is required

import Data.List (sortOn)
import qualified Data.Map.Strict as Map
import Data.Ord (Down (..))

text :: String
text = "the quick brown fox jumps over the lazy dog the fox barks"

main :: IO ()
main = mapM_ report ranked
  where
    counts = Map.fromListWith (+) [(word, 1 :: Int) | word <- words text]
    ranked = sortOn (\(word, count) -> (Down count, word)) (Map.toList counts)
    report (word, count) = putStrLn (word ++ " " ++ show count)
