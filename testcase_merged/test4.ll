; ModuleID = 'if'
source_filename = "if"
;将值Load出来未使用，用adce优化，判断0!=0，用constprop优化
define i32 @main(i32) {
if:
  %1 = alloca i32			;retAlloca
  %2 = alloca i32  			;twoAlloca
  %3 = alloca i32			;oneAlloca
  store i32 2, i32* %2			;store 2
  store i32 0, i32* %3			;store 0
  %4 = load i32, i32* %2		;load 0
  %5 = load i32, i32* %3		;load 1
  %6 = icmp ne i32 0, 0		
  br i1 %6, label %true_if, label %false_if

true_if:                                ; preds = %if
  store i32 1, i32* %1			; store 1 into retAlloca
  %7 = load i32, i32* %1		;load retAlloca into retLoad
  ret i32 %7

false_if:                               ; preds = %if
  store i32 0, i32* %1			; store 0 into retAlloca
  %8 = load i32, i32* %1		; load retAlloca into retLoad
  ret i32 %8
}
