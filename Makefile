all: fasst

fasst: lexer_utils.c lexer.c main.c
	gcc -g -o fasst lexer_utils.c lexer.c main.c

lexer.re: lexer.tpl
	python -m cogapp -d -o lexer.re lexer.tpl

lexer.c: lexer.re
	re2c -W -Werror -o lexer.c lexer.re

clean:
	rm -rf *.o *.pyc lexer.c fasst.exe lexer.re

.PHONY: all clean
