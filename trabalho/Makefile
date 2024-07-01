parser: lexico.l parser.y
	bison -d parser.y
	flex lexico.l
	cc -o parser parser.tab.c lex.yy.c -lfl

clean:
	rm -f parser parser.tab.c parser.tab.h lex.yy.c lex.yy.h

run: 
	./parser
