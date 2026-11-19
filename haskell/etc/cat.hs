-- cat.hs: Copy standard input to standard output
--
-- Description:
-- Copy standard input to standard output.
--
-- Author: id774 (More info: https://id774.net)
-- Source Code: https://github.com/id774/sandbox
-- License: The GPL version 3, or LGPL version 3 (Dual License).
-- Contact: idnanashi@gmail.com
--
-- Usage:
--     runghc cat.hs < input
--
-- Requirements:
-- - GHC (runghc)
--

main = do cs <- getContents
          putStr cs

