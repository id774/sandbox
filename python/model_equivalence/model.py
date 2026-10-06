# model.py
#
# Description:
#   Two deterministic implementations of the same account value and fee
#   model, and the result structures they share. This is a supporting file
#   of the model equivalence sample; test_model.py is the entry point.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   Imported by test_model.py. See README.md in this directory.

import math
from dataclasses import dataclass


@dataclass(frozen=True)
class ModelInput:
    contract_id: str
    initial_account_value: float
    annual_return: float
    fee_rate: float
    discount_rate: float
    years: int


@dataclass(frozen=True)
class YearResult:
    year: int
    start_account_value: float
    fee: float
    end_account_value: float
    discounted_fee: float


@dataclass(frozen=True)
class ModelResult:
    contract_id: str
    years: tuple[YearResult, ...]
    present_value: float


def run_old_model(p: ModelInput) -> ModelResult:
    balance = p.initial_account_value
    rows = []

    for year in range(1, p.years + 1):
        start = balance
        after_return = start * (1.0 + p.annual_return)
        fee = after_return * p.fee_rate
        balance = after_return - fee
        discounted_fee = fee / ((1.0 + p.discount_rate) ** year)
        rows.append(
            YearResult(
                year=year,
                start_account_value=start,
                fee=fee,
                end_account_value=balance,
                discounted_fee=discounted_fee,
            )
        )

    present_value = sum(row.discounted_fee for row in rows)
    return ModelResult(p.contract_id, tuple(rows), present_value)


def transition_new(start: float, p: ModelInput, year: int) -> YearResult:
    growth_factor = (
        (1.0 + p.annual_return)
        * (1.0 - p.fee_rate)
    )
    end = start * growth_factor

    fee = (
        start
        * (1.0 + p.annual_return)
        * p.fee_rate
    )

    discounted_fee = (
        fee
        * ((1.0 + p.discount_rate) ** -year)
    )

    return YearResult(
        year=year,
        start_account_value=start,
        fee=fee,
        end_account_value=end,
        discounted_fee=discounted_fee,
    )


def run_new_model(p: ModelInput) -> ModelResult:
    balance = p.initial_account_value
    rows = []

    for year in range(1, p.years + 1):
        row = transition_new(balance, p, year)
        rows.append(row)
        balance = row.end_account_value

    present_value = math.fsum(row.discounted_fee for row in rows)
    return ModelResult(p.contract_id, tuple(rows), present_value)
