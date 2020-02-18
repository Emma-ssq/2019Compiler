; ModuleID = 'test4.ll'
source_filename = "if"

define i32 @main(i32) {
if:
  %1 = alloca i32
  %2 = alloca i32
  %3 = alloca i32
  store i32 2, i32* %2
  store i32 0, i32* %3
  %4 = load i32, i32* %2
  %5 = load i32, i32* %3
  br i1 false, label %true_if, label %false_if

true_if:                                          ; preds = %if
  store i32 1, i32* %1
  %6 = load i32, i32* %1
  ret i32 %6

false_if:                                         ; preds = %if
  store i32 0, i32* %1
  %7 = load i32, i32* %1
  ret i32 %7
}
