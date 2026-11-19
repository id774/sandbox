# type_annotation.py: Averaging function with type annotations
#
# Description:
# Annotate an averaging function with typing.List and a float return type. The
# function raises ValueError for an empty list. type_annotation_test.py tests
# it.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#

from typing import List

def average(numbers: List[int]) -> float:
    if len(numbers) == 0:
        raise ValueError("The input list must not be empty")
    total = sum(numbers)
    return total / len(numbers)

