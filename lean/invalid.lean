-- invalid.lean: Rejected rfl proof of a false statement
--
-- Description:
-- Validation-boundary sample that attempts to prove the false statement
-- n + 1 = n with rfl. Lean is expected to reject the proof, so a failing
-- run with an error is the intended result, not a defect.
--
-- Author: id774 (More info: https://id774.net)
-- Source Code: https://github.com/id774/sandbox
-- License: The GPL version 3, or LGPL version 3 (Dual License).
-- Contact: idnanashi@gmail.com
--
-- Usage:
--     lean invalid.lean
--
-- Requirements:
-- - Lean 4 or later
-- - No Mathlib or other external package is required
--
-- Validated with Lean 4.33.1.

theorem add_one_wrong (n : Nat) : n + 1 = n := by
  rfl
