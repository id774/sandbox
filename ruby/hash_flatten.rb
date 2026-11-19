# hash_flatten.rb: Hash#flatten at different depths
#
# Description:
# Compare Hash#flatten at different depths.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby hash_flatten.rb
#
# Requirements:
# - Ruby
#

h = {:a=>1, :b=>[2,3], :c=>4}
p h.flatten(-1)
p h.flatten(0)
