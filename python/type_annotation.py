from typing import List

def average(numbers: List[int]) -> float:
    if len(numbers) == 0:
        raise ValueError("The input list must not be empty")
    total = sum(numbers)
    return total / len(numbers)

