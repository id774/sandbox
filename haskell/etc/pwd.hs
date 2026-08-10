-- Print the current working directory.

import Directory

main = getCurrentDirectory >>= putStrLn
