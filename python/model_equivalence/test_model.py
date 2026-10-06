# test_model.py
#
# Description:
#   Entry point of the model equivalence sample. It compares the old and new
#   model implementations in model.py through shared observations: exact
#   equality for discrete values, tolerance-based comparison for
#   floating-point values, and fixed scenarios. It also checks mathematical
#   invariants that treat neither implementation as the reference answer.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   From this directory:
#     python -m pytest -q
#
# Requirements:
#   - Python 3.10 or later
#   - pytest

import math
from dataclasses import replace

import pytest

from model import (
    ModelInput,
    ModelResult,
    run_new_model,
    run_old_model,
)

REL_TOL = 1e-9
ABS_TOL = 1e-12

CASES = [
    ModelInput(
        contract_id="C-001",
        initial_account_value=1_000_000.0,
        annual_return=0.03,
        fee_rate=0.01,
        discount_rate=0.02,
        years=3,
    ),
    ModelInput(
        contract_id="C-002",
        initial_account_value=500_000.0,
        annual_return=0.00,
        fee_rate=0.005,
        discount_rate=0.01,
        years=5,
    ),
    ModelInput(
        contract_id="C-003",
        initial_account_value=2_000_000.0,
        annual_return=-0.02,
        fee_rate=0.012,
        discount_rate=0.025,
        years=2,
    ),
]


def assert_discrete_values_equal(
    old: ModelResult,
    new: ModelResult,
) -> None:
    assert old.contract_id == new.contract_id
    assert len(old.years) == len(new.years)

    for old_row, new_row in zip(old.years, new.years):
        assert old_row.year == new_row.year


def assert_numeric_values_equivalent(
    old: ModelResult,
    new: ModelResult,
) -> None:
    for old_row, new_row in zip(old.years, new.years):
        year = old_row.year

        assert new_row.start_account_value == pytest.approx(
            old_row.start_account_value,
            rel=REL_TOL,
            abs=ABS_TOL,
        ), f"year={year}: start_account_value"
        assert new_row.fee == pytest.approx(
            old_row.fee,
            rel=REL_TOL,
            abs=ABS_TOL,
        ), f"year={year}: fee"
        assert new_row.end_account_value == pytest.approx(
            old_row.end_account_value,
            rel=REL_TOL,
            abs=ABS_TOL,
        ), f"year={year}: end_account_value"
        assert new_row.discounted_fee == pytest.approx(
            old_row.discounted_fee,
            rel=REL_TOL,
            abs=ABS_TOL,
        ), f"year={year}: discounted_fee"

    assert new.present_value == pytest.approx(
        old.present_value,
        rel=REL_TOL,
        abs=ABS_TOL,
    ), "present_value"


def assert_invariants(result: ModelResult, case: ModelInput) -> None:
    for row in result.years:
        after_return = (
            row.start_account_value
            * (1.0 + case.annual_return)
        )
        expected_fee = after_return * case.fee_rate
        expected_end = after_return - expected_fee

        assert row.fee == pytest.approx(
            expected_fee,
            rel=REL_TOL,
            abs=ABS_TOL,
        ), f"year={row.year}: fee"
        assert row.end_account_value == pytest.approx(
            expected_end,
            rel=REL_TOL,
            abs=ABS_TOL,
        ), f"year={row.year}: end_account_value"

    expected_present_value = math.fsum(
        row.discounted_fee for row in result.years
    )

    assert result.present_value == pytest.approx(
        expected_present_value,
        rel=REL_TOL,
        abs=ABS_TOL,
    ), "present_value"


@pytest.mark.parametrize("case", CASES)
def test_old_and_new_models_are_equivalent(
    case: ModelInput,
) -> None:
    old = run_old_model(case)
    new = run_new_model(case)

    assert_discrete_values_equal(old, new)
    assert_numeric_values_equivalent(old, new)


@pytest.mark.parametrize("case", CASES)
def test_each_model_satisfies_invariants(
    case: ModelInput,
) -> None:
    assert_invariants(run_old_model(case), case)
    assert_invariants(run_new_model(case), case)


def without_discount(result: ModelResult) -> ModelResult:
    return replace(
        result,
        present_value=sum(
            row.fee for row in result.years
        ),
    )


def test_shared_bug_can_escape_old_new_comparison() -> None:
    case = CASES[0]

    old_bugged = without_discount(run_old_model(case))
    new_bugged = without_discount(run_new_model(case))

    assert new_bugged.present_value == pytest.approx(
        old_bugged.present_value,
        rel=REL_TOL,
        abs=ABS_TOL,
    )

    with pytest.raises(AssertionError):
        assert_invariants(new_bugged, case)
