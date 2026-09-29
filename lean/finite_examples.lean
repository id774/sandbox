-- finite_examples.lean: Concrete Nat addition examples proved with rfl
--
-- Description:
-- Proves three concrete Nat addition examples with rfl. This is a valid
-- sample: Lean is expected to process it without errors.
--
-- Author: id774 (More info: https://id774.net)
-- Source Code: https://github.com/id774/sandbox
-- License: The GPL version 3, or LGPL version 3 (Dual License).
-- Contact: idnanashi@gmail.com
--
-- Usage:
--     lean finite_examples.lean
--
-- Requirements:
-- - Lean 4 or later
-- - No Mathlib or other external package is required
--
-- Validated with Lean 4.33.1.

example : (0 : Nat) + 0 = 0 := by
  rfl

example : (1 : Nat) + 0 = 1 := by
  rfl

example : (2 : Nat) + 0 = 2 := by
  rfl
