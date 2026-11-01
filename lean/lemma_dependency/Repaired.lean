-- Repaired.lean: Repaired downstream proof with the reverse inequality hypothesis
--
-- Description:
-- Repaired downstream proof with the reverse inequality hypothesis. Expected to succeed.
--
-- Author: id774 (More info: https://id774.net)
-- Source Code: https://github.com/id774/sandbox
-- License: The GPL version 3, or LGPL version 3 (Dual License).
-- Contact: idnanashi@gmail.com
--
-- Usage:
--     lean +leanprover/lean4:v4.35.0 Repaired.lean
--
-- Requirements:
-- - Lean 4.35.0 via elan
-- - No Mathlib or other external Lean packages
--
-- Target Lean version: 4.35.0.

theorem relation (x y : Nat) (h : x ≤ y) : x ≤ y := by
  exact h

theorem downstream_repaired (x y z : Nat)
    (hXY : x ≤ y) (hYX : y ≤ x) (hXZ : x ≤ z) : y ≤ z := by
  have hLE : x ≤ y := relation x y hXY
  have hEq : x = y := Nat.le_antisymm hLE hYX
  rw [← hEq]
  exact hXZ

#check downstream_repaired
#print axioms downstream_repaired
