-- sorry_example.lean: A false statement admitted with sorry
--
-- Description:
-- Validation-boundary sample that admits the false statement n + 1 = n
-- with sorry and prints the theorem's axiom dependencies, showing the
-- difference between a declaration Lean accepts and a trusted proof. Lean
-- is expected to process it with a warning about sorry, and the printed
-- axiom dependencies are expected to include sorryAx.
--
-- Author: id774 (More info: https://id774.net)
-- Source Code: https://github.com/id774/sandbox
-- License: The GPL version 3, or LGPL version 3 (Dual License).
-- Contact: idnanashi@gmail.com
--
-- Usage:
--     lean sorry_example.lean
--
-- Requirements:
-- - Lean 4 or later
-- - No Mathlib or other external package is required
--
-- Validated with Lean 4.33.1.

theorem add_one_fake (n : Nat) : n + 1 = n := by
  sorry

#print axioms add_one_fake
