-- Count the words of a fixed text, most frequent first and alphabetically within a tie.
-- Run: runghc word_frequency.hs

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
