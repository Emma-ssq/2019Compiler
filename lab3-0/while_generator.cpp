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
  auto module = new Module("while", context);  // module name是什么无关紧要

  // 函数参数类型的vector
  // main函数
  std::vector<Type *> Ints(2, TYPE32);
  auto mainFun = Function::Create(FunctionType::get(TYPE32, false),
                                  GlobalValue::LinkageTypes::ExternalLinkage,
                                  "main", module);
  auto bb = BasicBlock::Create(context, "entry", mainFun);
  builder.SetInsertPoint(bb);

  auto retAlloca = builder.CreateAlloca(TYPE32);  // 返回值的空间分配
  auto aAlloca = builder.CreateAlloca(TYPE32);    // 参数a的空间分配
  auto iAlloca = builder.CreateAlloca(TYPE32);    // 参数i的空间分配
  builder.CreateStore(CONST(10), aAlloca);//a = 10;
  builder.CreateStore(CONST(0), iAlloca);//i = 0;
  auto iLoad = builder.CreateLoad(iAlloca);//load i
  auto aLoad = builder.CreateLoad(aAlloca);//load a


  auto icmp = builder.CreateICmpSLT(iLoad, CONST(10));  // ICMPLT with S
  auto judgeBB = BasicBlock::Create(context,"judgeBB",mainFun);
  auto trueBB = BasicBlock::Create(context, "trueBB", mainFun);
  auto falseBB = BasicBlock::Create(context, "falseBB", mainFun);
  auto retBB = BasicBlock::Create(context, "retBB", mainFun);
  builder.CreateCondBr(icmp, trueBB, falseBB);//第一次判断，决定是否进入while循环
  //trueBB
  builder.SetInsertPoint(trueBB);
  auto oneAlloca = builder.CreateAlloca(TYPE32);
  builder.CreateStore(CONST(1),oneAlloca);
  auto oneLoad = builder.CreateLoad(oneAlloca);
  iLoad = builder.CreateLoad(iAlloca);
  auto add1 = builder.CreateNSWAdd(iLoad, oneLoad);//add1 = i + 1;
  builder.CreateStore(add1, iAlloca);// i = i + 1;
  aLoad = builder.CreateLoad(aAlloca);
  iLoad = builder.CreateLoad(iAlloca);
  auto add2 = builder.CreateNSWAdd(aLoad,iLoad);// add2 = a + i;
  builder.CreateStore(add2, aAlloca);//a = a + i;
  builder.CreateBr(judgeBB);
  //falseBB
  builder.SetInsertPoint(falseBB);
  builder.CreateBr(retBB);
  //judgeBB
  builder.SetInsertPoint(judgeBB);
  iLoad = builder.CreateLoad(iAlloca);
  icmp = builder.CreateICmpSLT(iLoad, CONST(10));
  builder.CreateCondBr(icmp, trueBB, falseBB);//判断，决定是否进入while循环
  //retBB
  builder.SetInsertPoint(retBB);
  auto retLoad = builder.CreateLoad(aAlloca);
  builder.CreateRet(retLoad);

  
  builder.ClearInsertionPoint();//结束
  module->print(outs(), nullptr);
  delete module;
  return 0;
}
