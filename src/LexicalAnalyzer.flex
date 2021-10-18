%%// Options of the scanner

%class Lexer	//Name
%unicode		//Use unicode
%line         	//Use line counter (yyline variable)
%column       	//Use character counter by line (yycolumn variable)
%type Symbol  //Says that the return type is Symbol
%standalone		//Standalone mode
%xstates YYINITIAL, CO_STATE, co_STATE


// Code that will be executed during the scan.
%{ 

	private java.util.ArrayList<Symbol> list_symbol = new java.util.ArrayList<Symbol>();
	private java.util.ArrayList<Symbol> list_variable = new java.util.ArrayList<Symbol>();

	/**
	 * Adds the symbol to the list of all symbols.
	 * @param symbol the symbol detected in the text
	 */
	public void addToSymbol(Symbol symbol){
		list_symbol.add(symbol);
	}

	/**
	 * Adds the symbol to the list of all symbols and to the list of variable if the value 
	 * of the symbol isn't already in this list.
	 * @param symbol the symbol (only a VARNAME symbol in this case) detected in the text
	 */
	public void addToVariableAndSymbol(Symbol symbol){
		addToSymbol(symbol);
		if (!checkExistingVariable(symbol)){
			list_variable.add(symbol);
		}
	}

	/**
	 * Checks if the symbol is already in the list of variables, returns true if the symbol
	 * is detected in the list.
	 * @param symbol the symbol detected in the text
	 * @return boolean
	 */
	public boolean checkExistingVariable(Symbol symbol){
		for (Symbol variable : list_variable){
            if (symbol.getValue().equals(variable.getValue())){
                return true;
            }
        }
        return false;
	}
%}


// Code that will be executed after the scan
%eof{
	
	// prints all the tokens
	for (Symbol symbol : list_symbol){
		System.out.println(symbol); 
	}

	// code for aesthetics
	System.out.println("\r");
	System.out.println("Variables :");

	// prints the line of first appearance of each variable
	for (Symbol var_symbol : list_variable){
		System.out.println(var_symbol.getValue() + " " + var_symbol.getLine()); 
	}

%eof}


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
EndOfLine      = "\r"?"\n"

Integer        = (([1-9][0-9]*)|0)
Identifier     = {Alpha}{AlphaNumeric}*


%%// Identification of tokens

// Relational operators
"not"		    {addToSymbol(new Symbol(LexicalUnit.NOT,yyline, yycolumn,yytext()));}
":="            {addToSymbol(new Symbol(LexicalUnit.ASSIGN,yyline, yycolumn,yytext()));}
"="	            {addToSymbol(new Symbol(LexicalUnit.EQUAL,yyline, yycolumn,yytext()));}
"-"             {addToSymbol(new Symbol(LexicalUnit.MINUS,yyline, yycolumn,yytext()));}
"+"             {addToSymbol(new Symbol(LexicalUnit.PLUS,yyline, yycolumn,yytext()));}
"*"             {addToSymbol(new Symbol(LexicalUnit.TIMES,yyline, yycolumn,yytext()));}
":"             {addToSymbol(new Symbol(LexicalUnit.DIVIDE,yyline, yycolumn,yytext()));}
">"		        {addToSymbol(new Symbol(LexicalUnit.GREATER,yyline, yycolumn,yytext()));}
"<"		        {addToSymbol(new Symbol(LexicalUnit.SMALLER,yyline, yycolumn,yytext()));}

// Others
"("             {addToSymbol(new Symbol(LexicalUnit.LPAREN,yyline, yycolumn,yytext()));}
")"             {addToSymbol(new Symbol(LexicalUnit.RPAREN,yyline, yycolumn,yytext()));}
";"             {addToSymbol(new Symbol(LexicalUnit.SEMICOLON,yyline, yycolumn,yytext()));}

// If-for-while keywords
"if"	        {addToSymbol(new Symbol(LexicalUnit.IF,yyline, yycolumn,yytext()));}
"then"          {addToSymbol(new Symbol(LexicalUnit.THEN,yyline, yycolumn,yytext()));}
"endif"         {addToSymbol(new Symbol(LexicalUnit.ENDIF,yyline, yycolumn,yytext()));}
"else"          {addToSymbol(new Symbol(LexicalUnit.ELSE,yyline, yycolumn,yytext()));}
"while"         {addToSymbol(new Symbol(LexicalUnit.WHILE,yyline, yycolumn,yytext()));}
"do"            {addToSymbol(new Symbol(LexicalUnit.DO,yyline, yycolumn,yytext()));}
"endwhile"      {addToSymbol(new Symbol(LexicalUnit.ENDWHILE,yyline, yycolumn,yytext()));}
"for"           {addToSymbol(new Symbol(LexicalUnit.FOR,yyline, yycolumn,yytext()));}
"from"          {addToSymbol(new Symbol(LexicalUnit.FROM,yyline, yycolumn,yytext()));}
"by"            {addToSymbol(new Symbol(LexicalUnit.BY,yyline, yycolumn,yytext()));}
"to"            {addToSymbol(new Symbol(LexicalUnit.TO,yyline, yycolumn,yytext()));}
"endfor"        {addToSymbol(new Symbol(LexicalUnit.ENDFOR,yyline, yycolumn,yytext()));}
"print"         {addToSymbol(new Symbol(LexicalUnit.PRINT,yyline, yycolumn,yytext()));}
"read"          {addToSymbol(new Symbol(LexicalUnit.READ,yyline, yycolumn,yytext()));}
"end"           {addToSymbol(new Symbol(LexicalUnit.END,yyline, yycolumn,yytext()));}	
"begin" 		{addToSymbol(new Symbol(LexicalUnit.BEG,yyline, yycolumn,yytext()));}


// States 
<YYINITIAL> {
	"CO" {yybegin(CO_STATE);}
	"co" {yybegin(co_STATE);}
}

<CO_STATE> {
	[^"CO"] {}
	"CO" {yybegin(YYINITIAL);}
}

<co_STATE> {
	[^"\r"?"\n"] {}
	{EndOfLine} {yybegin(YYINITIAL);}
}

// VARNAME variable identifier
{Identifier}  {addToVariableAndSymbol(new Symbol(LexicalUnit.VARNAME, yyline, yycolumn, yytext()));}

// NUMBER variable identifier
{Integer}  {addToSymbol(new Symbol(LexicalUnit.NUMBER,yyline, yycolumn,yytext()));}

//Ignore other characters
. | {EndOfLine}            {}

