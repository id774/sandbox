main = do
  putStrLn "挨拶といえば？: "
  greeting <- getLine
  answerToGreeting greeting

  putStrLn "なんか数字: " 
  num <- getLine
  putStrLn (checkNum num)

-- 純粋でない関数内の`if`
-- `then`, `else`のあとに`do`をつける
answerToGreeting greeting = do
  if greeting == "Hi"
    then do
      putStrLn "You speak English, don't you?"
    else do
      putStrLn "英語でおｋ"

-- 純粋な関数内の`if`
-- `then`, `else`のあとに`do`をつけない
checkNum num = 
  if num == "0" 
    then "ゼロ" 
    else "非ゼロ"
