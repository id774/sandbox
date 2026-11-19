# exact_binomial_test.R: One-sided exact binomial test
#
# Description:
# Test 17 successes out of 20 trials against p = 0.5 with a one-sided exact
# binomial test.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     Rscript exact_binomial_test.R
#
# Requirements:
# - R
#

binom.test(17, 20, p=0.5, alternative="greater")
