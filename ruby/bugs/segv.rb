# Crash the interpreter by redefining an IRB method during evaluation.

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
