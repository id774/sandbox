-- show.sql: Show drive model failure rates
--
-- Description:
-- Show the computed failure rate of every drive model from the failure_rates
-- table.
--
-- Author: id774 (More info: https://id774.net)
-- Source Code: https://github.com/id774/sandbox
-- License: The GPL version 3, or LGPL version 3 (Dual License).
-- Contact: idnanashi@gmail.com
--
-- Usage:
--     sqlite3 drive_stats.db < show.sql
--
-- Requirements:
-- - SQLite 3
-- - drive_stats.db prepared by batch.sh
--

select * from failure_rates order by model;
