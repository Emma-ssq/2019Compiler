; ModuleID = 'testc.ll'
source_filename = "testc.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @main() {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  store i32 3, i32* %2, align 4
  %5 = load i32, i32* %2, align 4
  %6 = add nsw i32 %5, 4
  store i32 %6, i32* %3, align 4
  %7 = load i32, i32* %2, align 4
  %8 = add nsw i32 4, %7
  store i32 %8, i32* %4, align 4
  %9 = load i32, i32* %4, align 4
  ret i32 %9
}
