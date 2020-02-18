;没有使用call函数的返回值，call指令被删除,用于adce
declare i32 @strlen(i8*) readonly nounwind
define void @test() {
call i32 @strlen( i8* null )
ret void
}


define dso_local i32 @array() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca [3 x i32], align 4
  store i32 0, i32* %1, align 4
  %4 = getelementptr inbounds [3 x i32], [3 x i32]* %3, i64 0, i64 2
  store i32 1, i32* %4, align 4
  %5 = getelementptr inbounds [3 x i32], [3 x i32]* %3, i64 0, i64 2 ;引用数组后未使用引用后的结果
  %6 = load i32, i32* %5, align 4
  store i32 1, i32* %2, align 4
  %7 = load i32, i32* %2, align 4
  %8 = load i32, i32* %2, align 4;此行被删去，相加时直接用上面load后的结果
  %9 = add nsw i32 %8, 1          

  ret i32 %7
}

define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4  ;变量声明后未使用
  store i32 0, i32* %1, align 4
  store i32 1, i32* %2, align 4
  %4 = load i32, i32* %2, align 4
  %5 = load i32, i32* %2		;将值Load出来未使用
  %6 = load i32, i32* %3		;将值Load出来未使用

  %7 = icmp sgt i32 %4, 0
  br i1 %7, label %8, label %9

; <label>:8:                                      
  store i32 1, i32* %2, align 4
  br label %10

; <label>:9:                                   
  store i32 2, i32* %2, align 4
  br label %10

; <label>:10:                                    
  %11=phi i32[1,%8],[2,%9]      ;使用Phi指令，但结果未被使用
  %12=phi i32[1,%8],[2,%9]
  ret i32 %4
}
