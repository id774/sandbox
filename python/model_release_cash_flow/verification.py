# verification.py: AI model release-delay cash-flow feasibility example
#
# Description:
#   Verify three monthly cash balances and the effect of reducing the final
#   month's compute payment in a fixed fictional release-delay scenario.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   From the repository root:
#     python3 -B python/model_release_cash_flow/verification.py
#
# Requirements:
#   - Python 3.10 or later
#   - Python standard library only
#   - Assertions enabled (do not use -O).

balance = 100  # 100 million JPY
minimum = 30  # 100 million JPY
months = [
    (20, 25, 8, 10),
    (15, 25, 8, 10),
    (10, 25, 8, 10),
]
expected_balances = (77, 49, 16)
expected_statuses = ("PASS", "PASS", "FAIL")

for month, (revenue, compute, evaluation, other) in enumerate(months, 1):
    balance += revenue - compute - evaluation - other
    status = "PASS" if balance >= minimum else "FAIL"
    assert balance == expected_balances[month - 1]
    assert status == expected_statuses[month - 1]
    print(f"month={month} balance={balance} status={status}")

assert minimum - balance == 14
revised_final_balance = balance + (months[2][1] - 10)
assert revised_final_balance == 31
assert revised_final_balance >= minimum
