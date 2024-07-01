parser: lexico.l
	# bison -d parser.y
	flex lexico.l
	# cc -o $@ parser.tab.c lex.yy.c -lfl
	gcc lex.yy.c -lfl
	rm lex.yy.c
	echo "test 1"
	./a.out ./test_lexico/t1
	echo "\ntest 2"
	./a.out ./test_lexico/t2
	echo "\ntest 3"
	./a.out ./test_lexico/t3
	echo "\ntest 4"
	./a.out ./test_lexico/t4
	echo "\ntest 5"
	./a.out ./test_lexico/t5
	echo "\ntest 6"
	./a.out ./test_lexico/t6
