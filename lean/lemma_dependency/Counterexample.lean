-- Counterexample.lean: Counterexample to the weakened universal theorem
--
-- Description:
-- Counterexample to the weakened universal theorem. Expected to succeed.
--
-- Author: id774 (More info: https://id774.net)
-- Source Code: https://github.com/id774/sandbox
-- License: The GPL version 3, or LGPL version 3 (Dual License).
-- Contact: idnanashi@gmail.com
--
-- Usage:
--     lean +leanprover/lean4:v4.35.0 Counterexample.lean
--
-- Requirements:
-- - Lean 4.35.0 via elan
-- - No Mathlib or other external Lean packages
--
-- Target Lean version: 4.35.0.

example : (1 : Nat) ≤ 3 := by
  decide

example : (1 : Nat) ≤ 2 := by
  decide

example : ¬ ((3 : Nat) ≤ 2) := by
  decide

theorem counterexample :
    ¬ (∀ x y z : Nat, x ≤ y → x ≤ z → y ≤ z) := by
  intro h
  have hYZ : (3 : Nat) ≤ 2 :=
    h 1 3 2 (by decide) (by decide)
  exact (by decide : ¬ ((3 : Nat) ≤ 2)) hYZ

#print axioms counterexample
