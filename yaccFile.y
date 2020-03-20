
%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	int yyerror(char*);
	int yylex();
	
	struct variable
	{
		char word_str[50][50];
		int num;
	};
	struct variable var[50];
	int index_var = 0;
%}

%token NUMBER NEWLINE VARIABLE WHILE WORD QUOTE CALCULATE INTEGER STRINGTYPE
%token IF ELSE THEN KE KED KBE KKE KB KK START END
%left '+' '-'
%left '*' '/'
%start BEGIN

%union
{
	int number;
	char* string;
}
%%

BEGIN: START STATEMENTS END	{
				printf("\nSYNTAX IS VALID\n\n");
				exit(1);
				}

		;


STATEMENTS: STATEMENT | STATEMENT STATEMENTS ;

STATEMENT : EXPR | IF_STATEMENT | ASSIGNMENT | LOOP | {printf("STRING IS: ");} STRING {printf("\n");}
	  | CALCULATOR ;


EXPR : EXPR '+' EXPR		{$<number>$ = $<number>1 + $<number>3; }

     | EXPR '-' EXPR		{$<number>$ = $<number>1 - $<number>3; }	

     | EXPR '*' EXPR 		{$<number>$ = $<number>1 * $<number>3; }

     | EXPR '/' EXPR   		{$<number>$ = $<number>1 / $<number>3;}

     | '-' EXPR			{$<number>$ = 0 - $<number>2;}

     | EXPR '=' EXPR		

     | NUMBER	

     | WORD			{
					int i = 0;
					while(1)
					{
						int a = strcmp(var[i].word_str[i], $<string>1);
						if(a == 0)
						{
							$<number>$ = var[i].num;
							break;
						}
						else
							i++;
						if(i==49)
						{
							printf("UNDEFINED VARIABLE IS USED. SYNTAX IS NOT VALID.\n");
							exit(0);
							break;
						}
					}
				}
   

     ;


IF_STATEMENT : MATCHED | UNMATCHED;


MATCHED : IF LOGIC_EXPR THEN MATCHED ELSE MATCHED
        | EXPR | ASSIGNMENT | LOOP ;



UNMATCHED : IF LOGIC_EXPR THEN EXPR
	  | IF LOGIC_EXPR THEN ASSIGNMENT
	  | IF LOGIC_EXPR THEN LOOP
	  | IF LOGIC_EXPR THEN MATCHED ELSE UNMATCHED;



LOGIC_EXPR: NUMBER LOGIC NUMBER | NUMBER | WORD LOGIC NUMBER | WORD LOGIC WORD;



LOGIC : KE | KED | KBE | KKE | KB | KK; 



ASSIGNMENT : INTEGER WORD '=' EXPR {$<number>$ = $<number>4;
			    	    strcpy(var[index_var].word_str[index_var],$<string>2);
			    	    var[index_var].num = $<number>4;
			    	    index_var++;

				   };



LOOP : WHILE LOGIC_EXPR ':' STATEMENTS;


STRING : STRINGTYPE WORD '=' QUOTE WORDS QUOTE;


WORDS : WORD  {printf("%s ",$<string>1);} | WORD {printf("%s ",$<string>1);}  WORDS  ;


CALCULATOR: CALCULATE '(' EXPR ')' {printf("RESULT IS: %d\n",$<number>3);}; 



%%


int yyerror(char *s)
{
	printf("ERROR : %s\n",s);
	exit(0);
}

int main()
{
	printf("PLEASE WRITE \"~start\" TO START THE PROGRAM AND \"~end\" TO EXIT.\n");
	yyparse();
	return 0;
}
