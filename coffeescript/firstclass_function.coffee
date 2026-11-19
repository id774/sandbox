# firstclass_function.coffee: Compose functions with their inverses
#
# Description:
# Compose each of sin, cos, and cube with its inverse and print the results
# for a value. firstclass_function.js is its compiled output.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     coffee firstclass_function.coffee
#
# Requirements:
# - CoffeeScript with Node.js
#

compose = (f, g) -> 
    (x) -> 
        f g x
 
fn  = [Math.sin,  Math.cos,  (x) -> Math.pow(x, 3)   ]
inv = [Math.asin, Math.acos, (x) -> Math.pow(x, 1/3) ]
 
do ->
	for i in [0..2]
        f = compose inv[i], fn[i]
        console.log f 0.5    # 0.5
