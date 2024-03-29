%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "common/common.h"
#include "syntax_tree/SyntaxTree.h"

#include "lab1_lexical_analyzer/lexical_analyzer.h"

// external functions from lex
extern int yylex();
extern int yyparse();
extern int yyrestart();
extern FILE * yyin;

// external variables from lexical_analyzer module
extern int lines;
extern char * yytext;

// Global syntax tree.
SyntaxTree * GlobSynTree;

void yyerror(const char *s);
%}

%union {
	struct _SyntaxTreeNode * type_node;
	int type_int;
	char* type_str;
}

/********** TODO: Your token definition here ***********/
%token  ADD 259 SUB 260 MUL 261 DIV 262 LT 263 LTE 264
%token GT 265 GTE 266 EQ 267 NEQ 268 ASSIN 269 SEMICOLON 270
%token COMMA 271 LPARENTHESE 272 RPARENTHESE 273 LBRACKET 274
%token RBRACKET 275 LBRACE 276 RBRACE 277 ELSE 278 IF 279 INT 280
%token RETURN 281 VOID 282 WHILE 283 ARRAY 286
%token <type_str> ERROR 258
%token <type_str> IDENTIFIER 284
%token <type_int> NUMBER 285
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
var_declaration:type_specifier IDENTIFIER SEMICOLON {
					$$ = newSyntaxTreeNode("var-declaration");
					SyntaxTreeNode_AddChild($$, $1);
					SyntaxTreeNode_AddChild($$, newSyntaxTreeNode($2));
					free($2);
					SyntaxTreeNode_AddChild($$, newSyntaxTreeNode(";"));
				}
				| type_specifier IDENTIFIER LBRACKET NUMBER RBRACKET SEMICOLON {
					$$ = newSyntaxTreeNode("var-declaration");
					SyntaxTreeNode_AddChild($$, $1);
					SyntaxTreeNode_AddChild($$, newSyntaxTreeNode($2));
					free($2);
					SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("["));
					SyntaxTreeNode_AddChild($$, newSyntaxTreeNodeFromNum($4));
					SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("]"));
					SyntaxTreeNode_AddChild($$, newSyntaxTreeNode(";"));
				};
type_specifier:	INT{
					$$ = newSyntaxTreeNode("type-specifier");
					SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("int"));
				}
				| VOID {
					$$ = newSyntaxTreeNode("type-specifier");
					SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("void"));
				};
fun_declaration:type_specifier IDENTIFIER LPARENTHESE params RPARENTHESE compound_stmt{
					$$ = newSyntaxTreeNode("fun-declaration");
					SyntaxTreeNode_AddChild($$, $1);
					SyntaxTreeNode_AddChild($$, newSyntaxTreeNode($2));
					free($2);
					SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("("));
					SyntaxTreeNode_AddChild($$, $4);
					SyntaxTreeNode_AddChild($$, newSyntaxTreeNode(")"));
					SyntaxTreeNode_AddChild($$, $6);
				};
params:	param_list {
			$$ = newSyntaxTreeNode("params");
			SyntaxTreeNode_AddChild($$, $1);
		}
		| VOID {
			$$ = newSyntaxTreeNode("params");
			SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("void"));
		};
param_list:	param_list COMMA param {
				$$ = newSyntaxTreeNode("param-list");
				SyntaxTreeNode_AddChild($$, $1);
				SyntaxTreeNode_AddChild($$, newSyntaxTreeNode(","));
				SyntaxTreeNode_AddChild($$, $3);
			}
			| param {
				$$ = newSyntaxTreeNode("param-list");
				SyntaxTreeNode_AddChild($$, $1);
			};
param:	type_specifier IDENTIFIER {
			$$ = newSyntaxTreeNode("param");
			SyntaxTreeNode_AddChild($$, $1);
			SyntaxTreeNode_AddChild($$, newSyntaxTreeNode($2));
			free($2);
		}
		| type_specifier IDENTIFIER ARRAY {
			$$ = newSyntaxTreeNode("param");
			SyntaxTreeNode_AddChild($$, $1);
			SyntaxTreeNode_AddChild($$, newSyntaxTreeNode($2));
			free($2);
			SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("[]"));
		};
compound_stmt:	LBRACE local_declarations statement_list RBRACE {
					$$ = newSyntaxTreeNode("compound-stmt");
					SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("{"));
					SyntaxTreeNode_AddChild($$, $2);
					SyntaxTreeNode_AddChild($$, $3);
					SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("}"));
				};
local_declarations:	local_declarations var_declaration {
						$$ = newSyntaxTreeNode("local-declarations");
						SyntaxTreeNode_AddChild($$, $1);
						SyntaxTreeNode_AddChild($$, $2);
					}
					| %empty {
						$$ = newSyntaxTreeNode("local-declarations");
						SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("epsilon"));
					};
statement_list:	statement_list statement {
					$$ = newSyntaxTreeNode("statement-list");
					SyntaxTreeNode_AddChild($$, $1);
					SyntaxTreeNode_AddChild($$, $2);
				}
				| %empty {
					$$ = newSyntaxTreeNode("statement-list");
					SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("epsilon"));
				};
statement:	expression_stmt {
				$$ = newSyntaxTreeNode("statement");
				SyntaxTreeNode_AddChild($$, $1);
			}
			| compound_stmt {
				$$ = newSyntaxTreeNode("statement");
				SyntaxTreeNode_AddChild($$, $1);
			}
			| selection_stmt {
				$$ = newSyntaxTreeNode("statement");
				SyntaxTreeNode_AddChild($$, $1);
			}
			| iteration_stmt {
				$$ = newSyntaxTreeNode("statement");
				SyntaxTreeNode_AddChild($$, $1);
			}
			| return_stmt {
				$$ = newSyntaxTreeNode("statement");
				SyntaxTreeNode_AddChild($$, $1);
			};
expression_stmt:expression SEMICOLON {
					$$ = newSyntaxTreeNode("expression-stmt");
					SyntaxTreeNode_AddChild($$, $1);
					SyntaxTreeNode_AddChild($$, newSyntaxTreeNode(";"));
				}
				| SEMICOLON {
					$$ = newSyntaxTreeNode("expression-stmt");
					SyntaxTreeNode_AddChild($$, newSyntaxTreeNode(";"));
				};
selection_stmt:	IF LPARENTHESE expression RPARENTHESE statement {
					$$ = newSyntaxTreeNode("selection-stmt");
					SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("if"));
					SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("("));
					SyntaxTreeNode_AddChild($$, $3);
					SyntaxTreeNode_AddChild($$, newSyntaxTreeNode(")"));
					SyntaxTreeNode_AddChild($$, $5);
				}
				| IF LPARENTHESE expression RPARENTHESE statement ELSE statement {
					$$ = newSyntaxTreeNode("selection-stmt");
					SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("if"));
					SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("("));
					SyntaxTreeNode_AddChild($$, $3);
					SyntaxTreeNode_AddChild($$, newSyntaxTreeNode(")"));
					SyntaxTreeNode_AddChild($$, $5);
					SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("else"));
					SyntaxTreeNode_AddChild($$, $7);
				};
iteration_stmt:	WHILE LPARENTHESE expression RPARENTHESE statement {
					$$ = newSyntaxTreeNode("iteration-stmt");
					SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("while"));
					SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("("));
					SyntaxTreeNode_AddChild($$, $3);
					SyntaxTreeNode_AddChild($$, newSyntaxTreeNode(")"));
					SyntaxTreeNode_AddChild($$, $5);
				};
return_stmt:RETURN SEMICOLON {
				$$ = newSyntaxTreeNode("return-stmt");
				SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("return"));
				SyntaxTreeNode_AddChild($$, newSyntaxTreeNode(";"));
			}
			| RETURN expression SEMICOLON {
				$$ = newSyntaxTreeNode("return-stmt");
				SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("return"));
				SyntaxTreeNode_AddChild($$, $2);
				SyntaxTreeNode_AddChild($$, newSyntaxTreeNode(";"));
			};
expression:	var ASSIN expression {
				$$ = newSyntaxTreeNode("expression");
				SyntaxTreeNode_AddChild($$, $1);
				SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("="));
				SyntaxTreeNode_AddChild($$, $3);
			}
			| simple_expression {
				$$ = newSyntaxTreeNode("expression");
				SyntaxTreeNode_AddChild($$, $1);
			};
var:IDENTIFIER {
		$$ = newSyntaxTreeNode("var");
		SyntaxTreeNode_AddChild($$, newSyntaxTreeNode($1));
		free($1);
	}
	| IDENTIFIER LBRACKET expression RBRACKET {
		$$ = newSyntaxTreeNode("var");
		SyntaxTreeNode_AddChild($$, newSyntaxTreeNode($1));
		free($1);
		SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("["));
		SyntaxTreeNode_AddChild($$, $3);
		SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("]"));
	};
simple_expression:	additive_expression relop additive_expression {
						$$ = newSyntaxTreeNode("simple-expression");
						SyntaxTreeNode_AddChild($$, $1);
						SyntaxTreeNode_AddChild($$, $2);
						SyntaxTreeNode_AddChild($$, $3);
					}
					| additive_expression {
						$$ = newSyntaxTreeNode("simple-expression");
						SyntaxTreeNode_AddChild($$, $1);
					};
relop:	LTE {
			$$ = newSyntaxTreeNode("relop");
			SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("<="));
		}
		| LT {
			$$ = newSyntaxTreeNode("relop");
			SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("<"));
		}
		| GT {
			$$ = newSyntaxTreeNode("relop");
			SyntaxTreeNode_AddChild($$, newSyntaxTreeNode(">"));
		}
		| GTE {
			$$ = newSyntaxTreeNode("relop");
			SyntaxTreeNode_AddChild($$, newSyntaxTreeNode(">="));
		}
		| EQ {
			$$ = newSyntaxTreeNode("relop");
			SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("=="));
		}
		| NEQ {
			$$ = newSyntaxTreeNode("relop");
			SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("!="));
		};
additive_expression:additive_expression addop term {
						$$ = newSyntaxTreeNode("additive-expression");
						SyntaxTreeNode_AddChild($$, $1);
						SyntaxTreeNode_AddChild($$, $2);
						SyntaxTreeNode_AddChild($$, $3);
					}
					| term {
						$$ = newSyntaxTreeNode("additive-expression");
						SyntaxTreeNode_AddChild($$, $1);
					};
addop:	ADD {
			$$ = newSyntaxTreeNode("addop");
			SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("+"));
		}
		| SUB {
			$$ = newSyntaxTreeNode("addop");
			SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("-"));
		};
term:term mulop factor {
		$$ = newSyntaxTreeNode("term");
		SyntaxTreeNode_AddChild($$, $1);
		SyntaxTreeNode_AddChild($$, $2);
		SyntaxTreeNode_AddChild($$, $3);
	}
	| factor {
		$$ = newSyntaxTreeNode("term");
		SyntaxTreeNode_AddChild($$, $1);
	};
mulop:	MUL {
			$$ = newSyntaxTreeNode("mulop");
			SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("*"));
		}
		| DIV {
			$$ = newSyntaxTreeNode("mulop");
			SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("/"));
		};
factor:	LPARENTHESE expression RPARENTHESE {
			$$ = newSyntaxTreeNode("factor");
			SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("("));
			SyntaxTreeNode_AddChild($$, $2);
			SyntaxTreeNode_AddChild($$, newSyntaxTreeNode(")"));
		}
		| var {
			$$ = newSyntaxTreeNode("factor");
			SyntaxTreeNode_AddChild($$, $1);
		}
		| call {
			$$ = newSyntaxTreeNode("factor");
			SyntaxTreeNode_AddChild($$, $1);
		}
		| NUMBER {
			$$ = newSyntaxTreeNode("factor");
			SyntaxTreeNode_AddChild($$, newSyntaxTreeNodeFromNum($1));
		};
call:IDENTIFIER LPARENTHESE args RPARENTHESE {
		$$ = newSyntaxTreeNode("call");
		SyntaxTreeNode_AddChild($$, newSyntaxTreeNode($1));
		free($1);
		SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("("));
		SyntaxTreeNode_AddChild($$, $3);
		SyntaxTreeNode_AddChild($$, newSyntaxTreeNode(")"));
	};
args:arg_list {
		$$ = newSyntaxTreeNode("args");
		SyntaxTreeNode_AddChild($$, $1);
	}
	| %empty {
		$$ = newSyntaxTreeNode("args");
		SyntaxTreeNode_AddChild($$, newSyntaxTreeNode("epsilon"));
	};
arg_list:arg_list COMMA expression {
			$$ = newSyntaxTreeNode("arg-list");
			SyntaxTreeNode_AddChild($$, $1);
			SyntaxTreeNode_AddChild($$, newSyntaxTreeNode(","));
			SyntaxTreeNode_AddChild($$, $3);
		}
		| expression {
			$$ = newSyntaxTreeNode("arg-list");
			SyntaxTreeNode_AddChild($$, $1);
		};
%%

void yyerror(const char * s){
	// TODO: variables in Lab1 updates only in analyze() function in lexical_analyzer.l
	//       You need to move position updates to show error output below
	fprintf(stderr, "%s:%d syntax error for %s\n", s, lines, yytext);
}

/// \brief Syntax analysis from input file to output file
///
/// \param input basename of input file
/// \param output basename of output file
void syntax(const char * input, const char * output){
	GlobSynTree = newSyntaxTree();

	char inputpath[256] = "./testcase/";
	char outputpath[256] = "./syntree/";
	strcat(inputpath, input);
	strcat(outputpath, output);

	if (!(yyin = fopen(inputpath, "r"))) {
		fprintf(stderr, "[ERR] Open input file %s failed.", inputpath);
		exit(1);
	}
	yyrestart(yyin);
	lines = 1;
	printf("[START]: Syntax analysis start for %s\n", input);
	FILE * ofp = fopen(outputpath, "w+");
	if (!ofp) return;

	// yyerror() is invoked when yyparse fail. If you still want to check the return value, it's OK.
	// `while (!feof(yyin))` is not needed here. We only analyze once.
	yyparse();
	printf("[OUTPUT] Printing tree to output file %s\n", outputpath);
	printSyntaxTree(ofp, GlobSynTree);
	deleteSyntaxTree(GlobSynTree);
	GlobSynTree = NULL;

	fclose(ofp);
	printf("[END] Syntax analysis end for %s\n", input);
}

/// \brief starting function for testing syntax module.
///
/// Invoked in test_syntax.c
int syntax_main(int argc, char ** argv){
	char filename[10][256];
	char output_file_name[256];
	const char * suffix = ".syntax_tree";
	int fn = getAllTestcase(filename);
	for (int i = 0; i < fn; i++) {
			int name_len = strstr(filename[i], ".cminus") - filename[i];
			strncpy(output_file_name, filename[i], name_len);
			strcpy(output_file_name+name_len, suffix);
			syntax(filename[i], output_file_name);
	}
	return 0;
}

