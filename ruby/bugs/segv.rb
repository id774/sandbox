# segv.rb: Interpreter crash from redefining an IRB method
#
# Description:
# Crash the interpreter by redefining an IRB method during evaluation.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     ruby segv.rb
#
# Requirements:
# - Ruby with irb
#

require 'irb'
IRB::Irb.module_eval do
  define_method(:eval_input) do
    IRB::Irb.module_eval { alias_method :eval_input, :to_s }
    # (A)
    GC.start
    Kernel
  end
end
IRB.start
