; ModuleID = 'test1.ll'
source_filename = "test1.ll"

; Function Attrs: nounwind readonly
declare i32 @strlen(i8*) #0

define void @test() {
  ret void
}

attributes #0 = { nounwind readonly }
