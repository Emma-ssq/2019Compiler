; ModuleID = 'while'
source_filename = "while"

define i32 @main() {
entry:
  %0 = alloca i32                                 ;allocate for retAlloca
  %1 = alloca i32                                 ;allocate for aAlloca
  %2 = alloca i32                                 ;allocate for iAlloca
  store i32 10, i32* %1                           ; a = 10
  store i32 0, i32* %2                            ; i = 0
  %3 = load i32, i32* %2                          ; get i / load i
  %4 = icmp slt i32 %3, 10                        ; if i < 10
  br i1 %4, label %trueBB, label %falseBB         ;br

judgeBB:                                          ; preds = %trueBB
  %5 = load i32, i32* %2                          ;load i
  %6 = icmp slt i32 %5, 10                        ;i < 10
  br i1 %6, label %trueBB, label %falseBB

trueBB:                                           ; preds = %judgeBB, %entry
  %7 = load i32, i32* %2                          ; get i / load i
  %8 = add nsw i32 %7, 1                         ; %8 = add nsw i32 1, %7
  store i32 %8, i32* %2                          ;store i into iAlloca 
  %9 = load i32, i32* %1                         ;load a
  %10 = load i32, i32* %2                         ;load i
  %11 = add nsw i32 %9, %10                      ;add a + i
  store i32 %11, i32* %1                          ;store a into aAlloca
  br label %judgeBB

falseBB:                                          ; preds = %judgeBB, %entry
  br label %retBB

retBB:                                            ; preds = %falseBB
  %12 = load i32, i32* %1                         ; load aAlloca into retLoad
  ret i32 %12                                     ; return 
}
