; ModuleID = 'call'
source_filename = "call"

define i32 @callee(i32) {
entry:
  %1 = alloca i32           ;retAlloca
  %2 = alloca i32           ;args[0]Alloc
  store i32 %0, i32* %2     ;store args[0] = a
  %3 = load i32, i32* %2    ;load a;
  %4 = mul nsw i32 2, %3    ;%4 = 2*a;
  store i32 %4, i32* %1     ;store 2*a into %1
  %5 = load i32, i32* %1    ;load 2*a into retAlloca
  ret i32 %5
}

define i32 @main() {
entry:
  %0 = call i32 @callee(i32 10) ;call the function callee
  ret i32 %0                    ;return 
}
