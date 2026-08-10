-- Branch with if in both an IO action and a pure function.

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
