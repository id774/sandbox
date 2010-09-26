import System

leap y = let m = (== 0) . (mod y) in if m 100 then m 400 else m 4
main = putStr (show (leap 2000))
