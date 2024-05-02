%{
#include "parser.tab.hh"
#include "racket_extensions.h" // Include the header file for Racket extensions
#include <sstream>
%}

%option noyywrap

%x strlit

%%
"int"                     {return INT_TYPE;}
"float"                   {return FLOAT_TYPE;}
"string"                  {return STRING_TYPE;}
"void"                    {return VOID_TYPE;}
"bool"                    {return BOOL_TYPE;}
"cons"                    {return CONS;}
"car"                     {return CAR;}
"cdr"                     {return CDR;}
";"                       {return SEMICOLON;}
"("                       {return LPAREN;}
")"                       {return RPAREN;}
"{"                       {return LBRACE;}
"}"                       {return RBRACE;}
","                       {return COMMA;}
"if"                      {return IF;}
"else"                    {return ELSE;}
"while"                   {return WHILE;}
"break"                   {return BREAK;}
"return"                  {return RETURN;}
"define"                  {return DEFINE;}
"lambda"                  {return LAMBDA;}
"cond"                    {return COND;}
"let"                     {return LET;}
"set!"                    {return SET;}
"quote"                   {return QUOTE;}
"quasiquote"              {return QUASIQUOTE;}
"unquote"                 {return UNQUOTE;}
"unquote-splicing"        {return UNQUOTE_SPLICING;}
"|"                       {return PIPE;}
"="                       {return EQUALS_SIGN;}
"||"                      {return LOGICAL_OR;}
"&&"                      {return LOGICAL_AND;}
"!"                       {return LOGICAL_NOT;}
">"                       {return RELOP_GT;}
"<"                       {return RELOP_LT;}
">="                      {return RELOP_GE;}
"<="                      {return RELOP_LE;}
"=="                      {return RELOP_EQ;}
"!="                      {return RELOP_NE;}
"+"                       {return ARITH_PLUS;}
"-"                       {return ARITH_MINUS;}
"*"                       {return ARITH_MULT;}
"/"                       {return ARITH_DIV;}
"%"                       {return ARITH_MOD;}
"..."                     {return VARIADIC;}
"false" | "true"          {yylval.boolval = strcmp(yytext, "true") == 0; return BOOL_LITERAL;}
[0-9]+                    {yylval.intval = atoi(yytext); return INT_LITERAL;}
([0-9]+[.])?[0-9]+        {yylval.fltval = atof(yytext); return FLOAT_LITERAL;}

# Character literal
"#\\".                    {yylval.charval = yytext[2]; return CHAR_LITERAL;}

\"                        { BEGIN strlit; ss.str(std::string()); }
<strlit>[^\\"\n]*         { ss << yytext;}
<strlit>\\n               { ss << '\n';}
<strlit>\\t               { ss << '\t';}
<strlit>\\[\\"]           { ss << yytext[1]; /*escaped quote or backslash*/ }
<strlit>\"                { yylval.strval = strdup((char *) ss.str().c_str()); BEGIN 0; return STRING_LITERAL; }
<strlit>\\.               { printf("Invalid escape character '%s'\n", yytext); }
<strlit>\n                { printf("Found newline in string\n"); }

# Pattern matching
"match"                   {return MATCH;}
"case"                    {return CASE;}
"else"                    {return ELSE;}

# Macros
"define-syntax"           {return DEFINE_SYNTAX;}
"syntax-rules"            {return SYNTAX_RULES;}
"define-macro"            {return DEFINE_MACRO;}

# Modules
"module"                  {return MODULE;}
"require"                 {return REQUIRE;}
"provide"                 {return PROVIDE;}

# Comments
";"                       { /* Ignore line comments */ }
"#"                       { /* Ignore line comments starting with # */ }
"/*"                      { BEGIN comment; }

<comment>"*/"             { BEGIN 0; }
<comment>.                { /* Ignore block comments */ }

[_a-zA-Z][_a-zA-Z0-9!?+-]* {yylval.strval = strdup(yytext); return ID;}
.                         {printf("Unrecognized character %c\n", *yytext);}
%%

/*int main(int argc, char **argv) {
  int tok;

  while((tok = yylex())) {
    printf("%d", tok);
    if(tok == INT_LITERAL) printf(" = %d\n", yyintval);
    else if (tok == FLOAT_LITERAL) printf(" = %0.3f\n", yyfltval);
    else if (tok == STRING_LITERAL) printf(" = %s\n", yytext);
    else if (tok == CHAR_LITERAL) printf(" = %c\n", yychrval);
    else if (tok == ID) printf(" called %s\n", yytext);
    else printf("\n");
  }
}
*/
