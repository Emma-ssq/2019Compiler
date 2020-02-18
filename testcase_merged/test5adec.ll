; ModuleID = 'test5.ll'
source_filename = "mytest.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local void @main() {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 1, i32* %2, align 4
  store i32 0, i32* %1, align 4
  %3 = load i32, i32* %2, align 4
  %4 = icmp sgt i32 %3, 0
  br i1 %4, label %5, label %6

; <label>:5:                                      ; preds = %0
  store i32 1, i32* %1, align 4
  br label %7

; <label>:6:                                      ; preds = %0
  store i32 2, i32* %1, align 4
  br label %7

; <label>:7:                                      ; preds = %6, %5
  ret void
}
