; ModuleID = 'mytest.c'
source_filename = "mytest.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"
;使用Phi指令，但结果未被使用，用adce优化
define dso_local void @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 1, i32* %3, align 4
  store i32 0, i32* %2, align 4
  %4 = load i32, i32* %3, align 4
  %5 = icmp sgt i32 %4, 0
  br i1 %5, label %6, label %7

; <label>:6:                                      ; preds = %0
  store i32 1, i32* %2, align 4
  br label %8

; <label>:7:                                      ; preds = %0
  store i32 2, i32* %2, align 4
  br label %8

; <label>:8:                                      ; preds = %7, %6
  %9=phi i32[1,%6],[2,%7]
  ret void
}

