%option noyywrap
%{
/*****************声明和选项设置  begin*****************/
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <dirent.h>
#include <unistd.h>
#include<string.h>
#include "lab1_lexical_analyzer/lexical_analyzer.h"
#include "common/common.h"

#ifndef LAB1_ONLY
#include "syntax_analyzer.h"
#endif

int files_count=0;
int lines;
int pos_start;
int pos_end;

/*****************声明和选项设置  end*****************/

%}

commentPattern "/*"([^\*]|(\*)*[^\*/])*(\*)*"*/"
identifierPattern [a-zA-Z][a-zA-Z]*

letter [A-Za-z]
digit [0-9]
number {digit}+
id {letter}+

%%

[\n] 	{
	lines += 1;
	pos_start = 1;
	pos_end = 1;
	//return BLANK;
}
[ ] 	{
	pos_start = pos_end;
	pos_end  += strlen(yytext);
	//return BLANK;
}
[\t] 	{
	pos_start = pos_end;
	pos_end  += strlen(yytext);
	//return BLANK;
}
[\r] 	{
	pos_start = pos_end;
	pos_end  += strlen(yytext);
	//return BLANK;
}
\[\]	{
	pos_start = pos_end;
	pos_end  += strlen(yytext);
	return ARRAY;
}

"/*"    { 
	pos_start = pos_end;
	pos_end  += strlen(yytext);
	char c;
        char prev = '\0';
        do{ 
         	c = input();
                pos_end += 1;
                if (c == EOF) break;//return ERROR;
                if (c == '\n') {lines++;pos_start = 1;pos_end = 1;}
                if (prev == '*' && c == '/') break;//return COMMENT;		
                prev = c;
          } while (1);
	
}

"+"	{
	pos_start = pos_end ;
	pos_end = pos_start + strlen("+");
	return ADD;
}
"-"	{
	pos_start = pos_end ;
	pos_end = pos_start + strlen("-");
	return SUB;
}
"*"	{
	pos_start = pos_end ;
	pos_end = pos_start + strlen("*");
	return MUL;
}
"/"	{
	pos_start = pos_end ;
	pos_end = pos_start + strlen("/");
	return DIV;
}
"<"	{
	pos_start = pos_end ;
	pos_end = pos_start + strlen("<");
	return LT;
}
"<="	{
	pos_start = pos_end ;
	pos_end = pos_start + strlen("<=");
	return LTE;
}
">"	{
	pos_start = pos_end ;
	pos_end = pos_start + strlen(">");
	return GT;
}
">="	{
	pos_start = pos_end ;
	pos_end = pos_start + strlen(">=");
	return GTE;
}
"=="	{
	pos_start = pos_end ;
	pos_end = pos_start + strlen("==");
	return EQ;
}
"!="	{
	pos_start = pos_end ;
	pos_end = pos_start + strlen("!=");
	return NEQ;
}
"="	{
	pos_start = pos_end ;
	pos_end = pos_start + strlen("=");
	return ASSIN;
}
;	{
	pos_start = pos_end ;
	pos_end = pos_start + strlen(";");
	return SEMICOLON;
}
,	{
	pos_start = pos_end ;
	pos_end = pos_start + strlen(",");
	return COMMA;
}

int  	{
	pos_start = pos_end ;
	pos_end = pos_start + strlen("int");
	return INT;
}
"("	{
	pos_start = pos_end ;
	pos_end = pos_start + strlen("(");
	return LPARENTHESE;

}

")"	{
	pos_start = pos_end ;
	pos_end = pos_start + strlen(")");
	return RPARENTHESE;

}
"["	{
	pos_start = pos_end ;
	pos_end = pos_start + strlen("[");
	return LBRACKET;

}
"]"	{
	pos_start = pos_end ;
	pos_end = pos_start + strlen("]");
	return RBRACKET;

}
"{"	{
	pos_start = pos_end ;
	pos_end = pos_start + strlen("{");
	return LBRACE;

}
"}"	{
	pos_start = pos_end ;
	pos_end = pos_start + strlen("}");
	return RBRACE;

}
if 	{
	pos_start = pos_end ;
	pos_end = pos_start + strlen("if");
	return IF;
}
else 	{
	pos_start = pos_end ;
	pos_end = pos_start + strlen("else");
	return ELSE;
}
return 	{
	pos_start = pos_end ;
	pos_end = pos_start + strlen("return");
	return RETURN;
}
void	{
	pos_start = pos_end ;
	pos_end = pos_start + strlen("void");
	return VOID;
}
while	{
	pos_start = pos_end ;
	pos_end = pos_start + strlen("while");
	return WHILE;
}
{number} { 	int number = atoi(yytext);
		pos_start = pos_end ;
		pos_end  = pos_start + strlen(yytext);
		#ifndef LAB1_ONLY
		yylval.type_int = number;
		#endif
		return NUMBER;
	}
{id} 	{ 
	  pos_start = pos_end ;
	  pos_end = pos_start + strlen(yytext);
	  #ifndef LAB1_ONLY
	 yylval.type_str = strdup(yytext);//yytext a pointer pointing to current content
	 //strcpy(yylval.type_str,yytext);
	  #endif
	  return IDENTIFIER;
	}
	


. 	{
	pos_start = pos_end; 
	pos_end += strlen(yytext);
	#ifndef LAB1_ONLY
	yylval.type_str = strdup(yytext);//yytext指向当前识别的词法单元（词文）的指针
	#endif
	return ERROR;
	}

%%


/****************C代码 start*************/

/// \brief analysize a *.cminus file
///
///	\param input_file_name
/// \param output_file_name
void analyzer(char* input_file_name, char* output_file_name){
	
	char input_path[256] = "./testcase/";
	strcat(input_path, input_file_name);
	char output_path[256] = "./tokens/";
	strcat(output_path, output_file_name);

	//open the .cminus file
	if(!(yyin = fopen(input_path,"r"))){
		printf("[ERR] No input file\n");
		exit(1);
	}
	// open succeed
	printf("[START]: Read from: %s\n", input_file_name);
	

	FILE *fp = fopen(output_path,"w+");

	int token;
	while(token = yylex()){
		switch(token){
			case ERROR:	
				{
				fprintf(fp, "[ERR]: unable to analysize %s at %d line, from %d to %d\n", yytext, lines, pos_start, pos_end);
				break;
				}
			case COMMENT:
			case BLANK:
				break;
			case EOL:
				break;
			default :
				fprintf(fp, "%s\t%d\t%d\t%d\t%d\n",yytext, token, lines, pos_start, pos_end);
		}
	}
	fclose(fp);
	printf("[END]: Analysis completed.\n");
}


/// \brief get all file paths under 'testcase' directory
///
/// under 'testcase' directory, there could be many *.cminus files.
/// \todo student should fill this function
/*
int getAllTestcase(char filename[][256]){
	DIR * dir;
    	struct dirent * ptr;
	dir = opendir("./testcase/"); //
	while((ptr = readdir(dir)) != NULL){
		if(strstr(ptr->d_name,".cminus")){
			files_count ++;
			strcpy(filename[files_count - 1],ptr->d_name);
		}
	}
		
	return files_count;
}
*/

// .cminus -> .token
char *outputname(char *str, int len, char *output_file_name){
	strncpy(output_file_name, str, len - strlen(".cminus"));
	strcat(output_file_name, ".tokens");
	int out_len = strlen(output_file_name);
	output_file_name[out_len] = '\0';	
}

/// \brief process all *.cminus file
/// note that: use relative path for all i/o operations
int lex_main(int argc, char **argv){
	char filename[10][256];
	char output_file_name[256];
	//char suffix[] = ".tokens";
	int j;
	for (j = 0;j< 256;j++)
		output_file_name[j] = '\0';
	getAllTestcase(filename);

	for(int i = 0; i < files_count; i++){
			 outputname(filename[i], strlen(filename[i]),output_file_name);
			 //reset :
			 lines = 1;
			 pos_start = 1;
			 pos_end = 1;
			 analyzer(filename[i],output_file_name);
			 //init: 
			 for (j = 0;j <256; j++)
				output_file_name[j] = '\0';
	}
	return 0;
}
/****************C代码 end*************/
