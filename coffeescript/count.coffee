# count.coffee: Log numbers through a debug function
#
# Description:
# Log 1, 2, and 3 through a debug function in a postfix comprehension.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     coffee count.coffee
#
# Requirements:
# - CoffeeScript with Node.js
#

debug = (x) -> console.log(x)
debug num for num in [1, 2, 3]
