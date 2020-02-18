; ModuleID = 'testc.ll'
source_filename = "testc.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define dso_local i32 @gcd(i32) {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %4 = load i32, i32* %2, align 4
  %5 = load i32, i32* %2, align 4
  %6 = mul nsw i32 %4, %5
  store i32 %6, i32* %3, align 4
  %7 = load i32, i32* %3, align 4
  ret i32 %7
}

define dso_local i32 @main() {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  store i32 3, i32* %2, align 4
  %6 = load i32, i32* %2, align 4
  %7 = add nsw i32 %6, 4
  store i32 %7, i32* %3, align 4
  %8 = load i32, i32* %2, align 4
  %9 = add nsw i32 4, %8
  store i32 %9, i32* %4, align 4
  %10 = load i32, i32* %2, align 4
  %11 = call i32 @gcd(i32 %10)
  store i32 %11, i32* %5, align 4
  %12 = load i32, i32* %4, align 4
  ret i32 %12
}
