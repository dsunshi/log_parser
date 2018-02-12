all: mtest

mtest: test_date.c test_suite.c ../munit/munit.c ../lexer_utils.c ../lexer.c ../lexer_symbols.c
	gcc -Wall -Wextra -g -o mtest test_date.c test_suite.c ../munit/munit.c ../lexer_utils.c ../lexer.c ../lexer_symbols.c

clean:
	rm -rf *.o *.txt mtest.exe

.PHONY: all clean
