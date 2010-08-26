@.LC0 = internal constant [13 x i8] c"Hello world!\00"

declare i32 @puts(i8 *)

define i32 @main() {
  %cast210 = getelementptr [13 x i8]* @.LC0, i32 0, i32 0
  call i32 @puts(i8 * %cast210)
  ret i32 0
}
