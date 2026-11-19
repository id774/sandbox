-- 0001_create_tickets.sql: D1 migration creating the tickets table
--
-- Description:
-- Create the tickets table that stores ticket bodies, routing results, attempt
-- counts, errors, and timestamps for the async ticket routing sample.
--
-- Author: id774 (More info: https://id774.net)
-- Source Code: https://github.com/id774/sandbox
-- License: The GPL version 3, or LGPL version 3 (Dual License).
-- Contact: idnanashi@gmail.com
--
-- Requirements:
-- - Wrangler, which applies it with npx wrangler d1 execute as README.md in
--   the project describes
--

CREATE TABLE tickets (
  id TEXT PRIMARY KEY,
  body TEXT NOT NULL,
  status TEXT NOT NULL,
  jev_model TEXT,
  jev_answers_json TEXT,
  department TEXT,
  department_probability REAL,
  department_confidence REAL,
  manual_review_probability REAL,
  urgency_score REAL,
  urgency_confidence REAL,
  final_route TEXT,
  attempts INTEGER NOT NULL DEFAULT 0,
  last_error TEXT,
  created_at TEXT NOT NULL,
  processed_at TEXT
);
