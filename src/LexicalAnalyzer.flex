%%// Options of the scanner

%class Main	//Name
%unicode		//Use unicode
%line         	//Use line counter (yyline variable)
%column       	//Use character counter by line (yycolumn variable)
%type Symbol  //Says that the return type is Symbol
%standalone		//Standalone mode
//%xstates YYINITIAL, VARNAME_STATE,


//%init{
//    //partie du code qui s'execute avant le début du scanner
//%init}
//
//%{
//    //partie du code qui s'execute pendant le scan.
//%}
//
//%eof{
//    partie du code qui s'execute apres le scanner.
//%eof}

// Return value of the program
%eofval{
	return new Symbol(LexicalUnit.END_OF_STREAM, yyline, yycolumn);
%eofval}

// Extended Regular Expressions

AlphaUpperCase = [A-Z]
AlphaLowerCase = [a-z]
Alpha          = {AlphaUpperCase}|{AlphaLowerCase}
Numeric        = [0-9]
AlphaNumeric   = {Alpha}|{Numeric}

Sign           = [+-]
Integer        = {Sign}?(([1-9][0-9]*)|0)
Decimal        = \.[0-9]*
Exponent       = [eE]{Integer}
Real           = {Integer}{Decimal}?{Exponent}?
Identifier     = {Alpha}{AlphaNumeric}*

%%// Identification of tokens

// Relational operators

//"!="	        {System.out.println("NOTEQUALS: " + yytext()); return new Symbol(LexicalUnit.NOTEQUALS,yyline, yycolumn);}
//">="	        {System.out.println("EGREATER: " + yytext()); return new Symbol(LexicalUnit.EGREATER,yyline, yycolumn);}
//"<="	        {System.out.println("ELOWER: " + yytext()); return new Symbol(LexicalUnit.ELOWER,yyline, yycolumn);}


"!"		        {System.out.println("NOT: " + yytext()); return new Symbol(LexicalUnit.NOT,yyline, yycolumn);}
"="             {System;out;println("ASSIGN: " + yytext()); return new Symbol(LexicalUnit.ASSIGN,yyline, yycolumn);}
"=="	        {System.out.println("EQUAL: " + yytext()); return new Symbol(LexicalUnit.EQUAL,yyline, yycolumn);}
"-"             {System.out.println("MINUS: " + yytext()); return new Symbol(LexicalUnit.MINUS,yyline, yycolumn);}
"+"             {System.out.println("PLUS: " + yytext()); return new Symbol(LexicalUnit.PLUS,yyline, yycolumn);}
"*"             {System.out.println("TIMES: " + yytext()); return new Symbol(LexicalUnit.TIMES,yyline, yycolumn);}
":"             {System.out.println("DIVIDE: " + yytext()); return new Symbol(LexicalUnit.DIVIDE,yyline, yycolumn);}
">"		        {System.out.println("GREATER: " + yytext()); return new Symbol(LexicalUnit.GREATER,yyline, yycolumn);}
"<"		        {System.out.println("SMALLER: " + yytext()); return new Symbol(LexicalUnit.SMALLER,yyline, yycolumn);}


//Others

"("             {System.out.println("LPAREN: " + yytext()); return new Symbol(LexicalUnit.LPAREN,yyline, yycolumn);}
")"             {System.out.println("RPAREN: " + yytext()); return new Symbol(LexicalUnit.RPAREN,yyline, yycolumn);}
";"             {System.out.println("SEMICOLON: " + yytext()); return new Symbol(LexicalUnit.SEMICOLON,yyline, yycolumn);}



// If/Else keywords
"if"	        {System.out.println("IF: " + yytext()); return new Symbol(LexicalUnit.IF,yyline, yycolumn);}
"then"          {System.out.println("THEN: " + yytext()); return new Symbol(LexicalUnit.THEN,yyline, yycolumn);}
"endif"         {System.out.println("ENDIF: " + yytext()); return new Symbol(LexicalUnit.ENDIF,yyline, yycolumn);}
"else"          {System.out.println("ELSE: " + yytext()); return new Symbol(LexicalUnit.ELSE,yyline, yycolumn);}
"while"         {System.out.println("WHILE: " + yytext()); return new Symbol(LexicalUnit.WHILE,yyline, yycolumn);}
"do"            {System.out.println("DO: " + yytext()); return new Symbol(LexicalUnit.DO,yyline, yycolumn);}
"endwhile"      {System.out.println("ENDWHILE: " + yytext()); return new Symbol(LexicalUnit.ENDWHILE,yyline, yycolumn);}
"for"           {System.out.println("FOR: " + yytext()); return new Symbol(LexicalUnit.FOR,yyline, yycolumn);}
"from"          {System.out.println("FROM: " + yytext()); return new Symbol(LexicalUnit.FROM,yyline, yycolumn);}
"by"            {System.out.println("BY: " + yytext()); return new Symbol(LexicalUnit.BY,yyline, yycolumn);}
"to"            {System.out.println("TO: " + yytext()); return new Symbol(LexicalUnit.TO,yyline, yycolumn);}
"endfor"        {System.out.println("ENDFOR: " + yytext()); return new Symbol(LexicalUnit.ENDFOR,yyline, yycolumn);}
"print"         {System.out.println("PRINT: " + yytext()); return new Symbol(LexicalUnit.PRINT,yyline, yycolumn);}
"read"          {System.out.println("READ: " + yytext()); return new Symbol(LexicalUnit.READ,yyline, yycolumn);}
"end"           {System.out.println("END: " + yytext()); return new Symbol(LexicalUnit.END,yyline, yycolumn);}
"begin" 		{System.out.println("BEGIN: " + yytext()); return new Symbol(LexicalUnit.BEGIN,yyline, yycolumn);}

// 


// VARNAME variable identifier
{Identifier}  {System.out.println("VARNAME: " + yytext()); return new Symbol(LexicalUnit.VARNAME,yyline, yycolumn); }

// NUMBER variable identifier
{Integer}  {System.out.println("NUMBER: " + yytext()); return new Symbol(LexicalUnit.NUMBER,yyline, yycolumn, new Double(yytext()));}

// States 

//Ignore other characters
.             {}