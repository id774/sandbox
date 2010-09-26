import IO
import Monad
import Char

main = do
       hSetBuffering stdin NoBuffering
       a <- getChar
       b <- getChar
       print a
       print b
