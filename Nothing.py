all:
	jflex src/LexicalAnalyzer.flex
	javac -d bin -cp src/ src/Main.java
	jar cfe dist/Part1.jar Main -C bin .

testing:
		java -jar dist/Part1.jar test/euclid.co
