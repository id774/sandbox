# migration_judge_validation.py: Evaluate old-new comparison judges
#
# Description:
#   Compare three judges against fixed observations from child processes
#   and measure false acceptance and false rejection of injected defects.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#   From this directory:
#     python3 -B migration_judge_validation.py
#
# Requirements:
#   - Python 3.10 or later
#   - Python standard library only
#
# Verified Environment:
#   Tested with Python 3.13.5 on Debian GNU/Linux 13 (x86_64).

import json
import math
import subprocess
import sys
from dataclasses import dataclass


@dataclass(frozen=True)
class Observation:
    returncode: int | None
    stdout: bytes
    stderr: bytes
    timed_out: bool = False


@dataclass(frozen=True)
class Case:
    name: str
    mode: str
    old: Observation
    new: Observation
    expected: bool


def observe(command, input_data):
    try:
        result = subprocess.run(
            command, input=input_data, capture_output=True,
            timeout=1.0, check=False, shell=False,
        )
        return Observation(result.returncode, result.stdout, result.stderr)
    except subprocess.TimeoutExpired as exc:
        return Observation(None, exc.stdout or b'', exc.stderr or b'', True)


def compare_raw(old, new, mode):
    return old.stdout.strip() == new.stdout.strip()


def compare_json(old, new, mode):
    if mode == 'raw':
        return compare_raw(old, new, mode)
    try:
        return json.loads(old.stdout) == json.loads(new.stdout)
    except (ValueError, RecursionError):
        return False


def reject_constant(value):
    raise ValueError(f'Non-finite constant: {value}')


def unique_object(pairs):
    result = {}
    for key, value in pairs:
        if key in result:
            raise ValueError(f'Duplicate key: {key}')
        result[key] = value
    return result


def finite_float(value):
    number = float(value)
    if not math.isfinite(number):
        raise ValueError(f'Non-finite number: {value}')
    return number


def strict_loads(data):
    return json.loads(
        data.decode('utf-8'), object_pairs_hook=unique_object,
        parse_constant=reject_constant, parse_float=finite_float,
    )


def equal_value(left, right):
    if type(left) is not type(right):
        return False
    if isinstance(left, dict):
        return left.keys() == right.keys() and all(
            equal_value(left[key], right[key]) for key in left
        )
    if isinstance(left, list):
        return len(left) == len(right) and all(
            equal_value(x, y) for x, y in zip(left, right)
        )
    if isinstance(left, float):
        return math.isclose(left, right, rel_tol=1e-9, abs_tol=1e-12)
    return left == right


def compare_contract(old, new, mode):
    if old.timed_out or new.timed_out:
        return False
    if old.returncode is None or new.returncode is None:
        return False
    if old.returncode != new.returncode or old.stderr != new.stderr:
        return False
    if mode == 'raw':
        return old.stdout == new.stdout
    if mode != 'json':
        raise ValueError(f'Unknown mode: {mode}')
    try:
        return equal_value(strict_loads(old.stdout), strict_loads(new.stdout))
    except (ValueError, RecursionError):
        return False


# Each child consumes the same stdin and emits a prescribed observation.
CHILD = (
    'import sys, time\n'
    'sys.stdin.buffer.read()\n'
    'sys.stdout.buffer.write(bytes.fromhex(sys.argv[1]))\n'
    'sys.stdout.buffer.flush()\n'
    'sys.stderr.buffer.write(bytes.fromhex(sys.argv[2]))\n'
    'sys.stderr.buffer.flush()\n'
    'time.sleep(float(sys.argv[4]))\n'
    'sys.exit(int(sys.argv[3]))\n'
)


def run_fixture(stdout, stderr=b'', code=0, delay=0):
    return observe(
        [sys.executable, '-c', CHILD, stdout.hex(), stderr.hex(),
         str(code), str(delay)], b'common input\n',
    )


def cases():
    # Expected decisions are fixed by the contract, before evaluation.
    rows = [
        ('P01', 'raw', b'abc', b'abc', True),
        ('P02', 'json', b'{"a":1,"b":2}', b'{"b":2,"a":1}', True),
        ('P03', 'json', b'{"a":1}', b'{ "a": 1 }', True),
        ('P04', 'json', b'1.0', b'1.0000000005', True),
        ('P05', 'json', b'0.0', b'5e-13', True),
        ('P06', 'raw', b'', b'', True, b'error', b'error', 2, 2),
        ('N01', 'raw', b'abc ', b'abc', False),
        ('N02', 'raw', b'abc', b'abc', False, b'', b'', 0, 1),
        ('N03', 'raw', b'abc', b'abc', False, b'', b'error'),
        ('N04', 'json', b'{"a":1}', b'{}', False),
        ('N05', 'json', b'true', b'1', False),
        ('N06', 'json', b'1', b'1.0', False),
        ('N07', 'json', b'9007199254740993', b'9007199254740992', False),
        ('N08', 'json', b'1.0', b'1.01', False),
        ('N09', 'json', b'1.0', b'NaN', False),
        ('N10', 'json', b'1.0', b'Infinity', False),
        ('N11', 'json', b'{"a":1}', b'{"a":2,"a":1}', False),
        ('N12', 'raw', b'abc', b'abc', False, b'', b'', 0, 0, 3),
        ('N13', 'json', b'1.0', b'1e400', False),
        ('N14', 'json', b'"a"', b'"\xff"', False),
        ('N15', 'json', b'[1,2]', b'[2,1]', False),
    ]
    for name, mode, left, right, expected, *options in rows:
        old_err, new_err, old_code, new_code, delay = (
            options + [b'', b'', 0, 0, 0][len(options):]
        )
        old = run_fixture(left, old_err, old_code)
        new = run_fixture(right, new_err, new_code, delay)
        if old != Observation(old_code, left, old_err):
            raise RuntimeError(f'{name}: invalid baseline observation')
        expected_new = Observation(
            None if delay else new_code, right, new_err, bool(delay)
        )
        if new != expected_new:
            raise RuntimeError(f'{name}: unexpected candidate observation')
        yield Case(name, mode, old, new, expected)


COMPARATORS = {
    'A': compare_raw,
    'B': compare_json,
    'C': compare_contract,
}


def evaluate(data, compare):
    decisions = {c.name: compare(c.old, c.new, c.mode) for c in data}
    tp = sum(c.expected and decisions[c.name] for c in data)
    tn = sum(not c.expected and not decisions[c.name] for c in data)
    fp = sum(not c.expected and decisions[c.name] for c in data)
    fn = sum(c.expected and not decisions[c.name] for c in data)
    return decisions, (tp, tn, fp, fn)


def metrics(counts):
    tp, tn, fp, fn = counts
    return fp / (fp + tn), fn / (fn + tp), (tp + tn) / sum(counts)


def main():
    data = list(cases())
    print('ID  expected A B C')
    results = {key: evaluate(data, fn) for key, fn in COMPARATORS.items()}
    for c in data:
        flags = [str(int(results[key][0][c.name])) for key in COMPARATORS]
        print(f'{c.name} {int(c.expected)}        {" ".join(flags)}')
    for key, (_, counts) in results.items():
        alpha, beta, accuracy = metrics(counts)
        print(f'{key}: TP,TN,FP,FN={counts}; '
              f'FAR={alpha:.2%} FRR={beta:.2%} accuracy={accuracy:.2%}')


if __name__ == '__main__':
    main()
