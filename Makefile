all: fasst

fasst: lexer_utils.c lexer.c main.c lexer_symbols.h lexer_symbols.c
	gcc -g -o fasst lexer_utils.c lexer_symbols.c lexer.c main.c

lexer.re: lexer.tpl.0
	python -m cogapp -d -o lexer.re lexer.tpl.0

lexer.tpl.0: lexer.tpl
	python -m cogapp -d -o lexer.tpl.0 lexer.tpl

lexer.c: lexer.re
	re2c -W -Werror --utf-8 -o lexer.c lexer.re

lexer_symbols.h: lexer_symbols.h.tpl
	python -m cogapp -d -o lexer_symbols.h lexer_symbols.h.tpl

lexer_symbols.c: lexer_symbols.c.tpl
	python -m cogapp -d -o lexer_symbols.c lexer_symbols.c.tpl

clean:
	rm -rf *.o *.pyc lexer.c fasst.exe lexer.re tokens.csv lexer.tpl.0 lexer_symbols.h lexer_symbols.c

.PHONY: all clean
