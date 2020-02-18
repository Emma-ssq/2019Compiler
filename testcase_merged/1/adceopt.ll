; ModuleID = 'adce.ll'
source_filename = "adce.ll"

; Function Attrs: nounwind readonly
declare i32 @strlen(i8*) #0

define void @test() {
  ret void
}

define dso_local i32 @array() {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca [3 x i32], align 4
  store i32 0, i32* %1, align 4
  %4 = getelementptr inbounds [3 x i32], [3 x i32]* %3, i64 0, i64 2
  store i32 1, i32* %4, align 4
  store i32 1, i32* %2, align 4
  %5 = load i32, i32* %2, align 4
  ret i32 %5
}

define dso_local i32 @main() {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  store i32 1, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = icmp sgt i32 %3, 0
  br i1 %4, label %5, label %6

; <label>:5:                                      ; preds = %0
  store i32 1, i32* %2, align 4
  br label %7

; <label>:6:                                      ; preds = %0
  store i32 2, i32* %2, align 4
  br label %7

; <label>:7:                                      ; preds = %6, %5
  ret i32 %3
}

attributes #0 = { nounwind readonly }
