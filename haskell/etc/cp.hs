-- cp.hs: Copy a file
--
-- Description:
-- Copy the file named by the first argument to the path named by the second.
--
-- Author: id774 (More info: https://id774.net)
-- Source Code: https://github.com/id774/sandbox
-- License: The GPL version 3, or LGPL version 3 (Dual License).
-- Contact: idnanashi@gmail.com
--
-- Usage:
--     runghc cp.hs <source> <destination>
--
-- Requirements:
-- - GHC with the haskell98 package, which provides the System module
--

import System

main = do args <- getArgs
          contents <- readFile (args!!0)
          writeFile (args!!1) contents
