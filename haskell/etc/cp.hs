-- Copy the file named by the first argument to the path named by the second.

import System

main = do args <- getArgs
          contents <- readFile (args!!0)
          writeFile (args!!1) contents
