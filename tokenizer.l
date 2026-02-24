%{
#include <stdio.h>
#include <string.h>
%}

%option noyywrap nodefault

DIGIT      [0-9]
INT        {DIGIT}+
VAR        [a-z][a-z0-9]{0,7}
WS         [ \t\r]+

%%
"="                 { printf("EQ\t%s\n", yytext); }
"+"                 { printf("PLUS\t%s\n", yytext); }
"*"                 { printf("TIMES\t%s\n", yytext); }
"("                 { printf("LPAREN\t%s\n", yytext); }
")"                 { printf("RPAREN\t%s\n", yytext); }
"\n"                { printf("EOL\t\\n\n"); }
{INT}               { printf("INT\t%s\n", yytext); }
{VAR}               { printf("VAR\t%s\n", yytext); }
{WS}                { /* skip */ }
[a-z][a-z0-9]{8,}   { printf("ERROR\t%s\n", yytext); }
.                   { printf("ERROR\t%s\n", yytext); }
%%

int main(void) {
  yylex();
  return 0;
}
