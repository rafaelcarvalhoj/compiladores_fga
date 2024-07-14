parser: lexico.l parser.y
	bison -d parser.y
	flex lexico.l
	cc -o parser parser.tab.c lex.yy.c -lfl

clean:
	rm -f parser parser.tab.c parser.tab.h lex.yy.c lex.yy.h

run: 
	./parser

moj:
	bison -d -o parser.tab.c parser.y
	flex -o lex.yy.c lexico.l
	cat parser.tab.c lex.yy.c > parser_combined.c
	gcc -E parser_combined.c > moj.c
