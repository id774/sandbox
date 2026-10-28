# delivery_handoff.py: Validate delivery data before a fixed return-window check
#
# Description:
#   Reject incomplete or inconsistent JSON delivery handoffs and evaluate a
#   fictional 30-day return window using validated dates.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   From the repository root:
#     python3 -B -m unittest discover -s python/agent_handoff_validation -p 'test_*.py' -v
#
# Requirements:
#   - Python 3.11 or later
#   - Python standard library only (json, re, datetime, unittest)
#   - No external APIs, credentials, or input files
#
import json
import re
from datetime import date


def validate_delivery(message: str, expected_order_id: str) -> date:
    try:
        delivery = json.loads(message)
    except json.JSONDecodeError as exc:
        raise ValueError("invalid JSON") from exc

    if not isinstance(delivery, dict):
        raise ValueError("expected JSON object")

    for field in ("order_id", "delivery_status", "delivered_at"):
        if field not in delivery:
            raise ValueError(f"missing {field}")

    order_id = delivery["order_id"]
    if not isinstance(order_id, str) or not order_id.strip():
        raise ValueError("invalid order_id")
    if order_id != expected_order_id:
        raise ValueError("order_id mismatch")
    if delivery["delivery_status"] != "delivered":
        raise ValueError("delivery is not completed")

    delivered_at = delivery["delivered_at"]
    if not isinstance(delivered_at, str) or re.fullmatch(
        r"[0-9]{4}-[0-9]{2}-[0-9]{2}", delivered_at
    ) is None:
        raise ValueError("invalid delivered_at format")
    try:
        return date.fromisoformat(delivered_at)
    except ValueError as exc:
        raise ValueError("invalid delivered_at date") from exc


def within_return_window(
    message: str, expected_order_id: str, requested_at: date
) -> bool:
    delivered_at = validate_delivery(message, expected_order_id)
    days = (requested_at - delivered_at).days
    if days < 0:
        raise ValueError("delivery date is after request date")
    return days <= 30
