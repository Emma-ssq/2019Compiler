# Lab2 语法分析

## PB17061266 孙书情

### 0.Requirements

实验主要就是在lab1词法分析得到的token基础上对连续输入的token进行语法分析自底向上进行shift，reduce。需要注意的是如何将lab1中的token具体表示的值：eg：identifier以及number类型表示的值传到lab2中。

除此之外，需要自学bison语法，还需要根据syntree里的小函数构造语法分析树。

### 1.Design

####1. c语言中一些记号的理解：

   - `#ifndef #endif` 	:头文件的条件引用

     ​		example: `#ifndef __COMMMON_COMMON_H__`	:表示如果引用`common/common.h`头文件，即则接		下来直到`#endif`中间的代码不会运行；否则如果不引用`common/common.h`会运行中间的代码。

####2. bison语言一些记号的理解：
- bison结构：

  ```bash
  %{
  C/C++头文件、全局文件、全局变量、类型定义
  词法分析器yylex（采用lex进行词法分析）和错误打印函数
  %}
  Bison声明区间。定义之后用到的终结符、非终结符、操作符优先级
  %%
  Bison语法规则定义
  %%
  C/C++代码 需要定义prologue区域函数，或者其他代码，生成的c/c++文件会完全拷贝这份代码。
  ```

  

- `token` 在.y文件中定义终结符。`type`在.y文件中定义非终结符。终结符使用词法分析来识别，而非终结符使用的归约方法。

 - 产生式的表达：`$$=$1+$2`,表示非终结符 = 产生式右侧第一个+产生式右侧第二个。

 - `union`定义终结符以及非终结符的类型，Bison中默认将所有的语义值都定义为int类型，可以通过定义宏YYSTYPE来改变值的类型。如果有多个值类型，则需要通过在Bison声明中使用%union列举出所有的类型。

   Union中的每一个项，都是一个语法规则的每一个非终结符。譬如：     

 - ~~~c
   %union {
   	struct _SyntaxTreeNode * type_node;
   	int type_int;
   	char* type_str;
   }
   //其中struct _SyntaxTreeNode *用来描述被识别出的type的信息,对应到c/c++代码中的类型。
   //表示token为IDENTIFIER型返回的是char*型
   %token <type_str> IDENTIFIER 284
    //表示token为NUMBER型返回的是int型
   %token <type_int> NUMBER 
   //表示语法分析type为program时，返回的是SyntaxTreeNode* 型
   %type <type_node> program 
   ```
   ~~~


#### 3.Cmake

经过这几天的资料调查，还有自己编了一个Makefile文件，我的理解是：Makefile文件就是一系列连续的终端命令，Cmake则是保证这种定义方式可以正常运行的工具包。​    

#### 4. 看懂助教的代码设计

这是一项大工程。首先我们来列举文件中的代码：

   1. `/common`: 整个编译器需要使用的全局函数以及全局变量，宏定义等。
     - `common.h`:	最主要声明了`int getALLTestcase(char filename[][256]);`遍历特定文件夹的 所有文件，将`.cminus`文件名称全部存入数组中。
     - `common.c`:	编写`getALLTestcase`函数，由于lab1，lab2，都要用到，所以写入common文件中。

   2. `/syntax_tree`:构造语法树的文件夹。
     
      - `SyntaxTree.h`：  只用于lab2，因此在测试lab1中
        												`#include "lab1_lexical_analyzer/lexical_analyzer.h"`, 声明了结构体`SyntaxTreeNode;`包含父亲节点，孩子节点，孩子数量，以及当前节点的名称。`SyntaxTree`：含有root的树；
                      								
              ```c
                  						
                  								//另外声明了一系列函数：
                  								//创建一个无名字的节点；
                  								SyntaxTreeNode * newSyntaxTreeNodeNoName();
                  								//创建一个有名字的节点；
                  								SyntaxTreeNode * newSyntaxTreeNode(const char * name);
                  								//创建NUMBER类型的节点；
                  								SyntaxTreeNode * newSyntaxTreeNodeFromNum(const int num);
                  								//插入孩子节点；
                  								int SyntaxTreeNode_AddChild(SyntaxTreeNode * parent, SyntaxTreeNode * child);
                  								//删除节点；
                  								void deleteSyntaxTreeNodeNoRecur(SyntaxTreeNode * node);
                  								//删除当前节点以及它的子树；
                  								void deleteSyntaxTreeNode(SyntaxTreeNode * node, int recursive);
                  								//创建新树；
                  								SyntaxTree * newSyntaxTree();
                  								//删除整个树；
                  								void deleteSyntaxTree(SyntaxTree * tree);
                  								//打印树；
                  	            								void printSyntaxTree(FILE * fout, SyntaxTree * tree);
         ```
         
         ```c
         //error:引入外部变量对错误进行定位。
         extern int lines;
         extern int pos_start;
         extern int pos_end;
         void yyerror(const char * s){
         	// TODO: variables in Lab1 updates only in analyze() function in lexical_analyzer.l
         	//       You need to move position updates to show error output below
         	fprintf(stderr, "%s:lines:%d, pos_start:%d, pos_end:%d, syntax error for %s\n", s, lines,pos_start,pos_end, yytext);
         }
         ```

   	        ```
   	- `/syntax_tree`:构造语法树的文件夹。
   
   	- `SyntaxTree.c`: 对应的.h函数的具体实现。
   
   	- `test_tree.c`： 测试syntax_tree

   3. `/lab1`: lab1的词法分析
   	 - `lexical_analyzer.h`:	定义了外部变量文件操作符，定义tokentype，声明了函数`const char * strtoken(Token t);`根据传入参数的Token返回相应的char* 串。

   	 - `lexical_analyzer.c`:	实现const char * strtoken(Token t);
   
   	 - `text_lex.c`: main函数，进行词法分析。
   
   	 - `lexical_analyzer.l`: 主要修改了main函数为lex_main函数，以免lab1，lab2同时运行时有多个main函数无法确定主从关系；另外引入`#ifndef LAB1_ONLY #include "syntax_analyzer.h" #endif` 来保证同时可以生成lab1，以及lab2的可执行文件。
   4. `/lab2`: lab2的语法分析
   	 - `syntax_analyzer.y`:	这是最重要的，除了一些文件操作，在接下来的大量篇幅将介绍bison语法，以及词法分析产生的token类型以及值如何传入语法分析中。

   	 - `test_syntax.c`:	top文件，运行lab2

2. 代码设计思想：

  - 首先先补全.l文件，以便实现词法分析功能，能够为语法分析生成终结符的token类型。
  - 接着考虑编写。y文件中的对%token -- 终结符的以及%type --非终结符，并且编写产生式的代码
  -  接着考虑如何生成语法分析树，观察`/syntax_tree`文件夹下的文件，利用`syntax_tree.c`文件里的函数进行生成节点，插入节点，生成树，最终print树的操作。应该对每一个产生式进行建节点，插入树。
  - 还需要考虑对特殊类型的终结符进行分析：对于空格换行注释在词法分析时不返回token，于是语法分析时不需要建立节点，插入树；对于`IDENTYFIER`类型的终止符，需要从词法分析中返回具体的char*字符串；对于`NUMBER`,需要从词法分析中返回具体的int数值。
  - 引入外部变量 , 补全yyerror函数。

### 2.Syntaxtree

####1.主要代码（示例只是部分）：

```c
%union {
	struct _SyntaxTreeNode * type_node;
	int type_num;
	char* type_id;
}

/********** TODO: Your token definition here ***********/
%token  ADD 259 SUB 260 MUL 261 DIV 262 LT 263 LTE 264
%token GT 265 GTE 266 EQ 267 NEQ 268 ASSIN 269 SEMICOLON 270
%token COMMA 271 LPARENTHESE 272 RPARENTHESE 273 LBRACKET 274
%token RBRACKET 275 LBRACE 276 RBRACE 277 ELSE 278 IF 279 INT 280
%token RETURN 281 VOID 282 WHILE 283 ARRAY 286
%token <type_id> ERROR 258
%token <type_id> IDENTIFIER 284
%token <type_num> NUMBER 285
%type <type_node> program declaration_list declaration var_declaration
%type <type_node> type_specifier fun_declaration params param_list param
%type <type_node> compound_stmt local_declarations statement_list statement
%type <type_node> expression_stmt selection_stmt iteration_stmt return_stmt
%type <type_node> expression var simple_expression relop additive_expression
%type <type_node> addop term mulop factor call args arg_list
/* compulsory starting symbol */
%start program

%%
program:declaration_list {
			GlobSynTree->root = $$ = newSyntaxTreeNode("program");
			SyntaxTreeNode_AddChild($$, $1);
		};
declaration_list:declaration_list declaration {
					$$ = newSyntaxTreeNode("declaration-list");
					SyntaxTreeNode_AddChild($$, $1);
					SyntaxTreeNode_AddChild($$, $2);
				}
				| declaration {
					$$ = newSyntaxTreeNode("declaration-list");
					SyntaxTreeNode_AddChild($$, $1);
				};
declaration:var_declaration {
				$$ = newSyntaxTreeNode("declaration");
				SyntaxTreeNode_AddChild($$, $1);
			}
			| fun_declaration {
				$$ = newSyntaxTreeNode("declaration");
				SyntaxTreeNode_AddChild($$, $1);
			};

%%
```

#### 2.示例文件输出语法树：

```c
//cminus文件
int function (int u) { 
     return u*u; 
}
//语法树：
>--+ program
|  >--+ declaration-list
|  |  >--+ declaration
|  |  |  >--+ fun-declaration
|  |  |  |  >--+ type-specifier
|  |  |  |  |  >--* int
|  |  |  |  >--* function
|  |  |  |  >--* (
|  |  |  |  >--+ params
|  |  |  |  |  >--+ param-list
|  |  |  |  |  |  >--+ param
|  |  |  |  |  |  |  >--+ type-specifier
|  |  |  |  |  |  |  |  >--* int
|  |  |  |  |  |  |  >--* u
|  |  |  |  >--* )
|  |  |  |  >--+ compound-stmt
|  |  |  |  |  >--* {
|  |  |  |  |  >--+ local-declarations
|  |  |  |  |  |  >--* epsilon
|  |  |  |  |  >--+ statement-list
|  |  |  |  |  |  >--+ statement-list
|  |  |  |  |  |  |  >--* epsilon
|  |  |  |  |  |  >--+ statement
|  |  |  |  |  |  |  >--+ return-stmt
|  |  |  |  |  |  |  |  >--* return
|  |  |  |  |  |  |  |  >--+ expression
|  |  |  |  |  |  |  |  |  >--+ simple-expression
|  |  |  |  |  |  |  |  |  |  >--+ additive-expression
|  |  |  |  |  |  |  |  |  |  |  >--+ term
|  |  |  |  |  |  |  |  |  |  |  |  >--+ term
|  |  |  |  |  |  |  |  |  |  |  |  |  >--+ factor
|  |  |  |  |  |  |  |  |  |  |  |  |  |  >--+ var
|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  >--* u
|  |  |  |  |  |  |  |  |  |  |  |  >--+ mulop
|  |  |  |  |  |  |  |  |  |  |  |  |  >--* *
|  |  |  |  |  |  |  |  |  |  |  |  >--+ factor
|  |  |  |  |  |  |  |  |  |  |  |  |  >--+ var
|  |  |  |  |  |  |  |  |  |  |  |  |  |  >--* u
|  |  |  |  |  |  |  |  >--* ;
|  |  |  |  |  >--* }
```





### 3.Errors & Solutions

1. 无法输出tree

1. 
	```bash
	syntax_error: 1 syntax error for
	```
  

 **Solution：**对于空格换行以及注释等终结符，并不会在语法分析中使用，因此词法分析应该对这些不如返回token或者在.y文件中%token不定义空格等。

2. 无法输出`IDENTIFIER`正确值，`NUMBER`正确值：

   **Solution:**

   ```c
   %union {
   	struct _SyntaxTreeNode * type_node;
   	int type_int; 
   	char* type_str;
   }
   %token <type_str> IDENTIFIER 284 //定义ID为char*
   %token <type_int> NUMBER 285 //定义NUMBER为int型
   ```

   修改.l文件，传入词法分析的值

   ```c
   {id} 	{ 
   	  pos_start = pos_end ;
   	  pos_end = pos_start + strlen(yytext);
   	  #ifndef LAB1_ONLY
   	 yylval.type_str = strdup(yytext);//yytext a pointer pointing to current content
   	 //strcpy(yylval.type_str,yytext);
   	  #endif
   	  return IDENTIFIER;
   	}
   {number} { 	int number = atoi(yytext);
   		pos_start = pos_end ;
   		pos_end  = pos_start + strlen(yytext);
   		#ifndef LAB1_ONLY
   		yylval.type_int = number;
   		#endif
   		return NUMBER;
   	}
   ```

3. strcpy与strdup的区别：

   1.strdup不是标准的c函数，需要注意加入库函数#include<string.h>，并且完成分析后free掉语法分析IDENTIFIER所占用的空间。，strcpy是标准的c函数，使用时注意场合。
   2.strdup可以直接把要复制的内容复制给没有初始化的指针，因为它会自动分配空间给目的指针，strcpy的目的指针一定是已经分配内存的指针。
   3.strdup用完要free()函数释放内存，否则内存泄露 。
   4.使用strcpy必须事先确定src大小，可以先strlen判断src的大小，之后为dest申请空间，之后再strcpy就不会有问题了。

   ```c
   call:IDENTIFIER LPARENTHESE args RPARENTHESE {
   		$$ = newSyntaxTreeNode("call");
   		SyntaxTreeNode_AddChild($$, newSyntaxTreeNode($1));
   		free($1);//free掉不再使用的空间
   		SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("("));
   		SyntaxTreeNode_AddChild($$, $3);
   		SyntaxTreeNode_AddChild($$, newSyntaxTreeNode(")"));
   	};
   ```

4. 使用yylval函数时一定要利用进行条件选择`#ifndef LAB1_ONLY  #endif `.保证在make同时产生lab1以及lab2的可执行文件（在运行lab1时，不能进行yylval.type_int函数，因为type_int只在lab2里声明了。）

   ```c
   	#ifndef LAB1_ONLY
   	yylval.type_int = number;
   	#endif
   ```

5. Error:a label can only be part of a statement and a declaration is not a statement.

   **Solutions:原因是由于我在case之后进行变量的声明而导致的错误**由于switch的几个case语句在同一个作用域（因为case 语句只是标签，它们共属于一个swtich语句块），所以如果在某个case下面声明变量的话，对象的作用域是在俩个花括号之间 也就是整个switch语句，其他的case语句也能看到，这样的话就可能导致错误。我们可以通过在case后面的语句加上大括号处理，之所以加大括号就是为了明确我们声明的变量的作用域，就是仅仅在本case之中，其实为了更规范的写switch-case语句，我们应该在case语句后边加大括号.



### 4.Summary

1. 在刚开始我自己写了build——syntaxtree的函数，因为自己没看到文件夹`/syntax`的文件，天哪，那就是一场噩梦。事实证明一定要认真看代码结构。
2. 对于flex，bison以及以后的新工具的代码结构，以及一些标志性的变量或者符号，一定要仔细调查相关说明，否则实验真的很难做出来。
3. 目前我还不会bison单步调试，希望在接下来lab3起初可以学一学。
### 5.Some suggestions
1. 希望助教可以把一些TODO标注的更清楚一些，尤其是对于未知工具flex，bison以及后面工具的介绍更清楚一些，事实上我们花费了极其大量的时间去弄明白实验到底要作什么。
2. 另外希望助教给多一点testcases，尤其是对于error的testcases，因为错误信息的输出真的是千奇百怪，有时真的很难区分怎么输出error信息。
3. 既然助教希望我们能多考虑一些边缘错误，那么也请助教能在布置实验之前尽量把边缘错误考虑清楚，类似此次实验中array分析时应该打印中括号而非小括号等错误可以尽量少一些发生，否则我们真的会在为助教debug上花费大量时间。

### 7.Total Time

1. 理解助教的代码框架：4小时

2. 查询bison语法，理解诸如%union，%token，%type等：6小时

3. 学习Cmake，试着编写Makefile文件：3小时

4. 编写初步的代码：3小时

5. 各种调试：10小时

6. 编写report：3小时

   总计35小时。

