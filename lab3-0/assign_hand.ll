; ModuleID = 'assign'
source_filename = "assign"

define i32 @main() {
assign:
  %0 = alloca i32 			;int a;
  store i32 1, i32* %0		;a = 1;
  br label %return

return:                                           ; preds = %assign
  %1 = load i32, i32* %0     ;load a =1 to return reg
  ret i32 %1				 ;return
}
