-- if.hs: if in an IO action and a pure function
--
-- Description:
-- Branch with if on a greeting read from standard input, in both an IO action
-- and a pure function.
--
-- Author: id774 (More info: https://id774.net)
-- Source Code: https://github.com/id774/sandbox
-- License: The GPL version 3, or LGPL version 3 (Dual License).
-- Contact: idnanashi@gmail.com
--
-- Usage:
--     runghc if.hs
--
-- Requirements:
-- - GHC (runghc)
--

main = do
  putStrLn "挨拶といえば？: "
  greeting <- getLine
  answerToGreeting greeting

  putStrLn "なんか数字: " 
  num <- getLine
  putStrLn (checkNum num)

-- `if` inside an impure function
-- Put `do` after `then` and `else`
answerToGreeting greeting = do
  if greeting == "Hi"
    then do
      putStrLn "You speak English, don't you?"
    else do
      putStrLn "英語でおｋ"

-- `if` inside a pure function
-- Omit `do` after `then` and `else`
checkNum num = 
  if num == "0" 
    then "ゼロ" 
    else "非ゼロ"
