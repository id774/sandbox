-- pascal.hs: The first 10 rows of Pascal's triangle
--
-- Description:
-- Print 10 rows of Pascal's triangle, taken from the infinite list each row of which zips the one before.
--
-- Part of the math cross-language exercise set: it reads no arguments or
-- standard input, keeps its data fixed in the source, uses integer
-- arithmetic only, and its output is the same as that of the same exercise
-- in every other language. The exercises are specified in README.md at the
-- repository root.
--
-- Author: id774 (More info: https://id774.net)
-- Source Code: https://github.com/id774/sandbox
-- License: The GPL version 3, or LGPL version 3 (Dual License).
-- Contact: idnanashi@gmail.com
--
-- Usage:
--     runghc pascal.hs
--
-- Requirements:
-- - GHC 7.10 or later (runghc), with the containers package that ships
--   with GHC
-- - No third-party package is required

rows :: [[Integer]]
rows = iterate next [1]
  where
    next row = zipWith (+) (0 : row) (row ++ [0])

main :: IO ()
main = mapM_ (putStrLn . unwords . map show) (take 10 rows)
