; ModuleID = 'testc.c'
source_filename = "testc.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"
;add指令1+2用constprop优化为3
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = add nsw i32 1,  2
  store i32 %6,i32* %1, align 4
  %7 = load i32,i32* %1,align 4
  ret i32 %7
}
