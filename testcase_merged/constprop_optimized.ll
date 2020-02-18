define <8 x i8> @test_truc_vec() {
  ret <8 x i8> <i8 1, i8 0, i8 0, i8 0, i8 2, i8 0, i8 0, i8 0>
}

define i32 @test() {
  ret i32 undef
}

define i32* @test1() {
  ret i32* null
}

define dso_local i32 @main() {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 3, i32* %1, align 4
  %6 = load i32, i32* %1, align 4
  br i1 false, label %true_if, label %false_if

true_if:                                          ; preds = %0
  store i32 1, i32* %1
  %7 = load i32, i32* %1
  ret i32 %7

false_if:                                         ; preds = %0
  store i32 0, i32* %1
  %8 = load i32, i32* %1
  ret i32 %6
}