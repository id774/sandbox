; hello2.ll: Print a string with puts from LLVM IR, a copy of hello.ll
;
; Description:
; Print a string by calling puts from hand written LLVM IR; identical to
; hello.ll.
;
; Author: id774 (More info: https://id774.net)
; Source Code: https://github.com/id774/sandbox
; License: The GPL version 3, or LGPL version 3 (Dual License).
; Contact: idnanashi@gmail.com
;
; Usage:
;     lli hello2.ll
;
; Requirements:
; - LLVM (lli) with a C library that provides puts
;

@.LC0 = internal constant [13 x i8] c"Hello world!\00"

declare i32 @puts(i8 *)

define i32 @main() {
  %cast210 = getelementptr [13 x i8]* @.LC0, i32 0, i32 0
  call i32 @puts(i8 * %cast210)
  ret i32 0
}
