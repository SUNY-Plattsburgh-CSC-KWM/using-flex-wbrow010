%{
#include <stdio.h>
#include <string.h>

/* Token names for printing */
static const char* tokname(int t) {
  switch (t) {
    case 1: return "INT";
    case 2: return "VAR";
    case 3: return "EQ";
    case 4: return "PLUS";
    case 5: return "TIMES";
    case 6: return "LPAREN";
    case 7: return "RPAREN";
    case 8: return "EOL";
    case 9: return "ERROR";
    default: return "?";
  }
}

static void emit(int t, const char* yytext) {
  printf("%s\t%s\n", tokname(t), yytext);
}
%}

%option noyywrap nodefault

DIGIT      [0-9]
INT        {DIGIT}+
VAR        [a-z][a-z0-9]{0,7}
WS         [ \t\r]+

%%
"="            { emit(3, yytext); }
"+"            { emit(4, yytext); }
"*"            { emit(5, yytext); }
"("            { emit(6, yytext); }
")"            { emit(7, yytext); }
"\n"           { emit(8, "\\n"); }

{INT}          { emit(1, yytext); }
{VAR}          { emit(2, yytext); }

{WS}           { /* skip */ }

/* If it starts like a variable but is too long, capture and error */
[a-z][a-z0-9]{8,}  { emit(9, yytext); }

/* Any other single char is an error */
.              { emit(9, yytext); }
%%

int main(void) {
  yylex();
  return 0;
}
