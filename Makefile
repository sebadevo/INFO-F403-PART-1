all:
	jflex exercice2.flex
	javac Lexer2.java
	java Lexer2 text.txt
