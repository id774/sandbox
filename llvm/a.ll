@str = internal constant [13 x i8] c"hello world\0A\00"

define void @main() nounwind
{
  %temp = call i32 @printf( i8* getelementptr ([13 x i8]* @str, i32 0,i32 0))
  ret void;
}

declare i32 @printf(i8*, ...) nounwind
