import System

main = do args <- getArgs
         contents <- readFile (args!!0)
         writeFile (args!!1) contents
