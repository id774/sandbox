-- pwd.hs: Print the current working directory
--
-- Description:
-- Print the current working directory.
--
-- Author: id774 (More info: https://id774.net)
-- Source Code: https://github.com/id774/sandbox
-- License: The GPL version 3, or LGPL version 3 (Dual License).
-- Contact: idnanashi@gmail.com
--
-- Usage:
--     runghc pwd.hs
--
-- Requirements:
-- - GHC with the haskell98 package, which provides the Directory module
--

import Directory

main = getCurrentDirectory >>= putStrLn
