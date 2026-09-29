-- universal.lean: Proof of n + 0 = n for every Nat
--
-- Description:
-- Proves n + 0 = n for every Nat with rfl and prints the axiom
-- dependencies of the theorem. This is a valid sample: Lean is expected to
-- process it without errors.
--
-- Author: id774 (More info: https://id774.net)
-- Source Code: https://github.com/id774/sandbox
-- License: The GPL version 3, or LGPL version 3 (Dual License).
-- Contact: idnanashi@gmail.com
--
-- Usage:
--     lean universal.lean
--
-- Requirements:
-- - Lean 4 or later
-- - No Mathlib or other external package is required
--
-- Validated with Lean 4.33.1.

theorem add_zero_all (n : Nat) : n + 0 = n := by
  rfl

#print axioms add_zero_all
