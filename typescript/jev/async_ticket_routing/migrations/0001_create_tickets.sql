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
