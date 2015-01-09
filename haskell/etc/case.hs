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
