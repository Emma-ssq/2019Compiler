
;常量的trunc指令可以被优化
define <8 x i8> @test_truc_vec() {
  %x = bitcast <2 x i64> <i64 1, i64 2> to <8 x i16>
  %y = trunc <8 x i16> %x to <8 x i8>
  ret <8 x i8> %y
}

;计算结果未定义的话将ret值直接改为undef
define i32 @test() {
        %R = sdiv i32 -2147483648, -1           ; <i32> [#uses=1]
        ret i32 %R
}

;%X由64位的0转换成i32*的null，再return %X的话，优化成ret null
define i32* @test1() {
        %X = inttoptr i64 0 to i32*             
        ret i32* %X
}

;add指令1+2用constprop优化为3
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = add nsw i32 1,  2
  store i32 %6,i32* %1, align 4     ;1+2->3
  %7 = load i32,i32* %1,align 4

  %8 = icmp ne i32 0, 0		
  br i1 %8, label %true_if, label %false_if ;%6->false

true_if:                         
  store i32 1, i32* %1			
  %9 = load i32, i32* %1		
  ret i32 %9

false_if:                              
  store i32 0, i32* %1			
  %10 = load i32, i32* %1		
  ret i32 %7
}
