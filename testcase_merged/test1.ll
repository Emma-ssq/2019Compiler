;没有使用call函数的返回值，call指令被删除,用于adce
declare i32 @strlen(i8*) readonly nounwind
define void @test() {
call i32 @strlen( i8* null )
ret void
}