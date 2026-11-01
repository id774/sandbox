-- Before.lean: Proof using an equality lemma to rewrite a downstream goal
--
-- Description:
-- Proof using an equality lemma to rewrite a downstream goal. Expected to succeed.
--
-- Author: id774 (More info: https://id774.net)
-- Source Code: https://github.com/id774/sandbox
-- License: The GPL version 3, or LGPL version 3 (Dual License).
-- Contact: idnanashi@gmail.com
--
-- Usage:
--     lean +leanprover/lean4:v4.35.0 Before.lean
--
-- Requirements:
-- - Lean 4.35.0 via elan
-- - No Mathlib or other external Lean packages
--
-- Target Lean version: 4.35.0.

theorem relation (x y : Nat) (h : x = y) : x = y := by
  exact h

theorem downstream (x y z : Nat)
    (hXY : x = y) (hXZ : x ≤ z) : y ≤ z := by
  have hEq : x = y := relation x y hXY
  rw [← hEq]
  exact hXZ

#check downstream
#print axioms downstream
