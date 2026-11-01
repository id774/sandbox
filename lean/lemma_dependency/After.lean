-- After.lean: Expected failure when an inequality lemma is used for equality rewriting
--
-- Description:
-- Expected failure when an inequality lemma is used for equality rewriting. Expected to be rejected at rw [← hLE].
--
-- Author: id774 (More info: https://id774.net)
-- Source Code: https://github.com/id774/sandbox
-- License: The GPL version 3, or LGPL version 3 (Dual License).
-- Contact: idnanashi@gmail.com
--
-- Usage:
--     lean +leanprover/lean4:v4.35.0 After.lean
--
-- Requirements:
-- - Lean 4.35.0 via elan
-- - No Mathlib or other external Lean packages
--
-- Target Lean version: 4.35.0.

theorem relation (x y : Nat) (h : x ≤ y) : x ≤ y := by
  exact h

theorem downstream (x y z : Nat)
    (hXY : x ≤ y) (hXZ : x ≤ z) : y ≤ z := by
  have hLE : x ≤ y := relation x y hXY
  rw [← hLE]
  exact hXZ
