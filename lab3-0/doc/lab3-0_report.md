## lab3-0实验报告

姓名：孙书情

学号：PB17061266

### 实验要求

1. 熟悉LLVM IR的结构，通过终端命令`clang -S -emit-llvm filename.c`查看机器自动产生的`.ll`文件（可能是优化过的），通过查看机器产生的文件，并结合汇编程序的相关知识，可以快速理解代码各个block的含义。
2. 手动编写赋值，if判断，while循环，函数调用的汇编程序，这其中一定要理解store，load指令的作用。
3. 理解助教编写的gcc_generator.cpp的代码，即利用C++中的相关库函数以及相关类来打印输出.ll文件，其中主要理解builder中的几个函数就行。

### 实验结果
####assign

1. `assign_hand.ll`

   - 代码结构：首行和第二行就是介绍c文件名，接下来define 定义了main函数，其返回值为i32类型的，main前面的@可理解为函数的特定声明。然后在main块中定义不同的Basicblock：`assign`用于实现简单的赋值，其中包括重要的store ，load语句，将在下面着重说明；`return`用于实现返回值，其实可以不用这个模块，在`assign`模块中增加几条语句就行，但是为了程序的可读性，我的全部代码都设置了独立的`return`模块。
   - store：`store i32 1 , i32* %0`表示将`CONST(1)`的地址存入了reg 0中，因此reg 0 中不是数值1
   - load：`%1 = load i32 , i32* %0`表示将reg 0存的地址所指向的数值存入reg 1中，此时reg 1 存入的`CONST(1)`

   ```bash
   ; ModuleID = 'assign'
   source_filename = "assign"
   
   define i32 @main() {
   assign:
     %0 = alloca i32 				;int a;
     store i32 1, i32* %0		;a = 1;
     br label %return
   
   return:                      ; preds = %assign
     %1 = load i32, i32* %0     ;load a =1 to return reg
     ret i32 %1				 				 ;return
   ```
   
2. `assign_generator.cpp`

   主要有几个函数：

   - 创建函数块：`  auto mainFun = Function::Create(FunctionType::get(TYPE32, false),
                                       GlobalValue::LinkageTypes::ExternalLinkage,
                                       "main", module);`
   - BasicBlock创建: `BasicBlock::Create(context, "assign", mainFun);`
   - 指示 BasicBlock开始：`builder.SetInsertPoint(basicblock_name);`
   - 分配内存空间：`auto aAlloca = builder.CreateAlloca(TYPE32);//int a;`
   - 存储指令：`builder.CreateStore(CONST(1), aAlloca);//a = 1;`
   - load指令：` auto aLoad = builder.CreateLoad(aAlloca);// load a `
   - 无条件跳转指令：` builder.CreateBr(retBB);  // br retBB`
   - 返回指令：`builder.CreateRet(retLoad);//return特定`


```c++
#include <llvm/IR/BasicBlock.h>
#include <llvm/IR/Constants.h>
#include <llvm/IR/DerivedTypes.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Type.h>
#include <llvm/IR/Verifier.h>

#include <iostream>
#include <memory>

#ifdef DEBUG  // 用于调试信息,大家可以在编译过程中通过" -DDEBUG"来开启这一选项
#define DEBUG_OUTPUT std::cout << __LINE__ << std::endl;  // 输出行号的简单示例
#else
#define DEBUG_OUTPUT
#endif

using namespace llvm;  // 指明命名空间为llvm
#define CONST(num) \
  ConstantInt::get(context, APInt(32, num))  //得到常数值的表示,方便后面多次用到

int main() {
 LLVMContext context;
  Type *TYPE32 = Type::getInt32Ty(context);
  IRBuilder<> builder(context);
 auto module = new Module("assign", context);  // module name是什么无关紧要

// 函数参数类型的vector
  std::vector<Type *> Ints(2, TYPE32);

//main函数
  auto mainFun = Function::Create(FunctionType::get(TYPE32, false),
                                  GlobalValue::LinkageTypes::ExternalLinkage,
                                  "main", module);
  auto bb=BasicBlock::Create(context, "assign", mainFun);
  auto retBB = BasicBlock::Create( context, "return", mainFun);  // return分支,提前create,以便true分支可以br

  builder.SetInsertPoint(bb);
  auto aAlloca = builder.CreateAlloca(TYPE32);//int a;
  auto retAlloca = builder.CreateAlloca(TYPE32); //返回值retAlloca空间的分配

  builder.CreateStore(CONST(1), aAlloca);//a = 1;
  auto aLoad = builder.CreateLoad(aAlloca);// load a 
  builder.CreateStore(aLoad, retAlloca);//把a存入返回值retAlloca中
  builder.CreateBr(retBB);  // br retBB

  builder.SetInsertPoint(retBB);  // ret分支
  auto retLoad = builder.CreateLoad(retAlloca);
  builder.CreateRet(retLoad);//return特定

  builder.ClearInsertionPoint();//结束
  module->print(outs(), nullptr);
  delete module;
  return 0;
}

```

#### if

1. `if_hand.ll`

   与赋值语句不同的是：增添了有条件跳转指令。if条件判断basicblock中：设置了`br i1 true, label %true_if, label %false_if	`用来判断跳转到那一个basicblock上，另外为了减少使用的register的数量，我在判断模块中便为返回值分配了空间，true_if表示trueBB，实现将1存入返回值分配的空间中，false_if实现将0存入返回值空间中。

   ```bash
   ; ModuleID = 'if'
   source_filename = "if"
   
   define i32 @main(i32) {
   if:
     %1 = alloca i32								;allocate for retAlloca
     br i1 true, label %true_if, label %false_if	;br
   
   true_if:                                ; preds = %if
     store i32 1, i32* %1
     %2 = load i32, i32* %1				;load 1 into retAlloca
     ret i32 %2
   
   false_if:                               ; preds = %if
     store i32 0, i32* %1
     %3 = load i32, i32* %1				;load 0 into retALloca
     ret i32 %3
   }
   ```

2. `if_generator.cpp`

   ```c++
   /* 只列举了代码中的关键部分 main函数中 已经设置了mainFun模块*/
     auto bb = BasicBlock::Create(context, "if_condition", mainFun);
     builder.SetInsertPoint(bb);                     // 一个BB的开始
     auto retAlloca = builder.CreateAlloca(TYPE32);  // 返回值的空间分配
    
     auto icmp = builder.CreateICmpSGT(CONST(2), CONST(1));  //有条件跳转
     auto trueBB = BasicBlock::Create(context, "true_if_condition", mainFun);
     auto falseBB = BasicBlock::Create(context, "false_if_condition", mainFun);
   
     builder.CreateCondBr(icmp, trueBB, falseBB); //跳转开始
   
     builder.SetInsertPoint(trueBB);
     builder.CreateStore(CONST(1), retAlloca);//第一个为数值，第二个为目的地
     auto retLoad1 = builder.CreateLoad(retAlloca);
     builder.CreateRet(retLoad1);//return特定
   /* falseBB 类似 */
   ```

   
#### while

1. `while_hand.ll`

   - 这是本次实验中最难的一个题目，主要涉及到如何通过跳转实现循环。其实就是设计一个`judgeBB`用来判断循环条件是否满足，这有点类似if语句，只不过要考虑将trueBB最终的跳转目的地指向judgeBB，将falseBB的目的地指向retBB，如此便实现了判断与循环。
   - 另外此实验使用了加法操作，在这部分中store，load指令起到了非常重要的作用，在我的代码中我使用的是`add nsw ` 命令，规定加数与被加数都是数值，而非地址，因此不能也不应该将aAlloca 作为加数或被加数，因为aAlloca中存入的是地址，准确的说，在我的代码里aAlloca类型是`i32*`，不是`i32`.此外不能出现类似 `%9 = add nsw i32 %9, %10  `的操作，即和与加数或被加数使用一个寄存器，而应该分开，在后续操作中将和再store入加数或被加数中。
   
   ```bash 
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
   ```
   
2. `while_generator.cpp`

   ```c++
   /* 同if_generator.cpp 只显示重要的代码 */
     /* entry */
     auto bb = BasicBlock::Create(context, "entry", mainFun);
     builder.SetInsertPoint(bb);
     auto retAlloca = builder.CreateAlloca(TYPE32);  // 返回值的空间分配
     auto aAlloca = builder.CreateAlloca(TYPE32);    // 参数a的空间分配
     auto iAlloca = builder.CreateAlloca(TYPE32);    // 参数i的空间分配
     builder.CreateStore(CONST(10), aAlloca);//a = 10;
     builder.CreateStore(CONST(0), iAlloca);//i = 0;
   
     auto iLoad = builder.CreateLoad(iAlloca);
     auto aLoad = builder.CreateLoad(aAlloca);
     auto icmp = builder.CreateICmpSLT(iLoad, CONST(10));  // ICMPLT with S
   
     auto judgeBB = BasicBlock::Create(context,"judgeBB",mainFun);
     auto trueBB = BasicBlock::Create(context, "trueBB", mainFun);
     auto falseBB = BasicBlock::Create(context, "falseBB", mainFun);
     auto retBB = BasicBlock::Create(context, "retBB", mainFun);
     builder.CreateCondBr(icmp, trueBB, falseBB);//第一次判断，决定是否进入while循环
   	 /* trueBB */
      builder.SetInsertPoint(trueBB);
      auto oneAlloca = builder.CreateAlloca(TYPE32);
      builder.CreateStore(CONST(1),oneAlloca);
      auto oneLoad = builder.CreateLoad(oneAlloca);
      iLoad = builder.CreateLoad(iAlloca);
      auto add1 = builder.CreateNSWAdd(iLoad, oneLoad);//add1 = i + 1;
      builder.CreateStore(add1, iAlloca);// i = i + 1;
      aLoad = builder.CreateLoad(aAlloca);// load a
      iLoad = builder.CreateLoad(iAlloca); // load i
      auto add2 = builder.CreateNSWAdd(aLoad,iLoad);// add2 = a + i;
      builder.CreateStore(add2, aAlloca);//a = a + i;
      builder.CreateBr(judgeBB);
   	 /* falseBB */
      builder.SetInsertPoint(falseBB);
      builder.CreateBr(retBB);
   	 /* judgeBB */
      builder.SetInsertPoint(judgeBB);
      iLoad = builder.CreateLoad(iAlloca);
      icmp = builder.CreateICmpSLT(iLoad, CONST(10));
      builder.CreateCondBr(icmp, trueBB, falseBB);//判断，决定是否进入while循环
   	 /* retBB */
      builder.SetInsertPoint(retBB);
      auto retLoad = builder.CreateLoad(aAlloca);
      builder.CreateRet(retLoad);
   ```
####call

1. `call_my.ll`

   - 主要涉及一个函数调用的函数 ` %0 = call i32 @callee(i32 10) ;call the function callee`

   ```bash
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
   
   ```

   

2. `call_generator.cpp`

   - 函数传参函数：首先，`callee`只有一个参数因此` std::vector<Type *> Ints(1, TYPE32);`设置了1个参数；其次如何获取传入的参数int a，利用了下列函数

     ` std::vector<Value *> args;
       for (auto arg = calleeFun->arg_begin(); arg != calleeFun->arg_end(); arg++) ` `{
         args.push_back(arg);
       }`

     再将args[0]地址存入aAlloca中：` builder.CreateStore(args[0], aAlloca);`

   - main函数调用： `auto callee = builder.CreateCall(calleeFun, {CONST(10)});` 其中{ }表示传入的参数，不可丢。

   ```c++
   	//callee 函数
     std::vector<Type *> Ints(1, TYPE32);// 函数参数类型的vector
     auto calleeFun = Function::Create(FunctionType::get(TYPE32, Ints, false),
                                    GlobalValue::LinkageTypes::ExternalLinkage,
                                    "callee", module);
     auto bb = BasicBlock::Create(context, "entry", calleeFun);
     builder.SetInsertPoint(bb);                    
     auto retAlloca = builder.CreateAlloca(TYPE32);  // 返回值的空间分配
     auto aAlloca = builder.CreateAlloca(TYPE32);    // 参数a的空间分配
     std::vector<Value *> args;  //获取callee函数的参数
     for (auto arg = calleeFun->arg_begin(); arg != calleeFun->arg_end(); arg++) {
       args.push_back(arg);
     }
     builder.CreateStore(args[0], aAlloca);  //将参数a store下来
     auto aLoad = builder.CreateLoad(aAlloca);           //将参数v load上来
     auto amul = builder.CreateNSWMul(CONST(2), aLoad); 
     builder.CreateStore(amul, retAlloca);//把u存入返回值retAlloca中
     auto retLoad = builder.CreateLoad(retAlloca);
     builder.CreateRet(retLoad);//返回
     // main函数
     auto mainFun = Function::Create(FunctionType::get(TYPE32, false),
                                     GlobalValue::LinkageTypes::ExternalLinkage,
                                     "main", module);
     bb = BasicBlock::Create(context, "entry", mainFun);
     // BasicBlock的名字在生成中无所谓,但是可以方便阅读
     builder.SetInsertPoint(bb);
     auto callee = builder.CreateCall(calleeFun, {CONST(10)});
     builder.CreateRet(callee);//return特定
   ```

   


### 实验难点

1. 安装LLVM-IR，实际上助教给的说明很详细，这纯属我的手残，在安装过程中意外关闭了虚拟机，导致重装虚拟机，好在没有出现其他的bug，不过由于电脑性能有限，还是花费4个小时装机，不过这期间可以补作业。

2. 编写`.ll`文件时reg寄存器顺序报错。

   **Soluton：**这是由于在汇编语言中不可以跳跃式的使用寄存器，即在没有使用%2时，不可以直接使用%3，不过好在编译可以检查并定位出来这种error，节省很很多时间。

3. 编写`.ll`文件时add指令报错

   **Solution：**这是由于没有理解store，load指令造成的error。一定要注意，store存入的是数值的地址，load取出地址所指向的数值，而add nsw指令对应的两个操作数均是数值，而非地址。

### 实验总结

1. 事实上，本次实验较为简单，无论从实验原理还是实验内容设计均比lab2，lab1简单很多，各种机器上，以及命令上的错误也很少出现，得感谢助教，编写了非常详细的文档说明。
2. 操作上，第一次使用如此大的软件，需要make2-3个小时，很庆幸中间没有出现bug，否则安装软件的过程想必会很痛苦。
3. 期待着lab3_1的说明文档能像这次一样清晰，助教加油。

### 花费时间

1. 安装llvm-IR ：4hours
2. 理解lab3_0说明文档，查找相关llvm-IR资料：1hour
3. 编写.cpp文件并调试运行至成功：1hour + 1.5hours
4. 编写.ll文件: 0.5hour
5. 写报告：1hour
6. total time： 9hour（其中包括4小时的安装环境，可以删去3小时）



