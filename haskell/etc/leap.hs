-- leap.hs: Leap year test
--
-- Description:
-- Test whether a year is a leap year.
--
-- Author: id774 (More info: https://id774.net)
-- Source Code: https://github.com/id774/sandbox
-- License: The GPL version 3, or LGPL version 3 (Dual License).
-- Contact: idnanashi@gmail.com
--
-- Usage:
--     runghc leap.hs
--
-- Requirements:
-- - GHC with the haskell98 package, which provides the System module
--

import System

leap y = let m = (== 0) . (mod y) in if m 100 then m 400 else m 4
main = putStr (show (leap 2000))
