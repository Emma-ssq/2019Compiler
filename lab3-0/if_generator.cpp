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
  auto module = new Module("if", context);  // module name是什么无关紧要

  // 函数参数类型的vector
  std::vector<Type *> Ints(1, TYPE32);
  auto mainFun = Function::Create(FunctionType::get(TYPE32, Ints, false),
                                 GlobalValue::LinkageTypes::ExternalLinkage,
                                 "main", module);
  // BB的名字在生成中无所谓,但是可以方便阅读
  auto bb = BasicBlock::Create(context, "if_condition", mainFun);
  builder.SetInsertPoint(bb);                     // 一个BB的开始
  auto retAlloca = builder.CreateAlloca(TYPE32);  // 返回值的空间分配
  auto twoAlloca = builder.CreateAlloca(TYPE32);
  auto oneAlloca = builder.CreateAlloca(TYPE32);
  builder.CreateStore(CONST(2),twoAlloca);
  builder.CreateStore(CONST(1),oneAlloca);
  auto twoLoad = builder.CreateLoad(twoAlloca);
  auto oneLoad = builder.CreateLoad(oneAlloca);
 
  //judge
  auto icmp = builder.CreateICmpSGT(twoLoad, oneLoad);  // ICMPLT with S
  auto trueBB = BasicBlock::Create(context, "true_if_condition", mainFun);
  auto falseBB = BasicBlock::Create(context, "false_if_condition", mainFun);
  builder.CreateCondBr(icmp, trueBB, falseBB);
  // trueBB
  builder.SetInsertPoint(trueBB);
  builder.CreateStore(CONST(1), retAlloca);//第一个为数值，第二个为目的地
  auto retLoad1 = builder.CreateLoad(retAlloca);
  builder.CreateRet(retLoad1);//return特定
  //falseBB
  builder.SetInsertPoint(falseBB);
  builder.CreateStore(CONST(0), retAlloca);//第一个为数值，第二个为目的地
  auto retLoad2 = builder.CreateLoad(retAlloca);
  builder.CreateRet(retLoad2);//return特定

  builder.ClearInsertionPoint();//结束
  module->print(outs(), nullptr);
  delete module;
  return 0;
}

