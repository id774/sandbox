-- case.hs: Number to English with case
--
-- Description:
-- Map a numeric string read from standard input to English with case, in both
-- an IO action and a pure function.
--
-- Author: id774 (More info: https://id774.net)
-- Source Code: https://github.com/id774/sandbox
-- License: The GPL version 3, or LGPL version 3 (Dual License).
-- Contact: idnanashi@gmail.com
--
-- Usage:
--     runghc case.hs
--
-- Requirements:
-- - GHC (runghc)
--

main = do
  putStrLn "number: "
  num <- getLine
  printInEnglish num
  putStrLn (numInEnglish num)

printInEnglish num = do
  case num of
    "1" -> do
      putStrLn "one"
    "2" -> do
      putStrLn "two"
    "3" -> do
      putStrLn "three"
    _   -> do
      putStrLn "I don't know"

numInEnglish num =
  case num of
    "1" -> "one"
    "2" -> "two"
    "3" -> "three"
    _   -> "I don't know"
