
%%// option of the scanner

%class Lexer2 //Name
%unicode //Use unicode
%standalone


//%init{
//    System.out.println(
//                       "-------------------------"+"\n"+
//                       "je vais débuter l'analyse"+"\n"+
//                       "-------------------------"+"\n"
//                                                        );
//%init}   
%{
    private int a = 0;
    private int l = 0;
    private int sp = 0;
    private int s = 0;
    private int n = 0;

    private void countANC(){
        a++;
    }

    private void countL(){
        l++;
    }

    private void countSP(){
        sp++;
    }

    private void countS(){
        s++;
    }

    private void countN(){
        n++;
    }
%}

%eof{
    System.out.println("\n"+"-------------------------");
    System.out.println("j'ai fini l'analyse");
    System.out.println("le nombre signe: " + s);
    System.out.println("le nombre charactere : " + a);
    System.out.println("le nombre de ligne : " + l);
    System.out.println("le nombre d'espace : " + sp);
    System.out.println("le nombre de singe d'onomatopé : " + n);
    System.out.println("-------------------------");
%eof}        // code exécuter à la fin de l'analyse.

// regular expression

AlphaNumChar = [A-Z]|[a-z]|[0-9]
EndOfLine = "\r"?"\n"
Space = "\t" | " "
Sign = "{" | "}"


%%
{Sign} {countS();}
{AlphaNumChar} {countANC();}
{EndOfLine} {countL();}
<<EOF>> {return 0;}
{Space} {countSP();}
. {countN();}
