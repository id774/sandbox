; a.ll: Print a string with printf from LLVM IR
;
; Description:
; Print a string by calling printf from hand written LLVM IR.
;
; Author: id774 (More info: https://id774.net)
; Source Code: https://github.com/id774/sandbox
; License: The GPL version 3, or LGPL version 3 (Dual License).
; Contact: idnanashi@gmail.com
;
; Usage:
;     lli a.ll
;
; Requirements:
; - LLVM (lli) with a C library that provides printf
;

@str = internal constant [13 x i8] c"hello world\0A\00"

define void @main() nounwind
{
  %temp = call i32 @printf( i8* getelementptr ([13 x i8]* @str, i32 0,i32 0))
  ret void;
}

declare i32 @printf(i8*, ...) nounwind
