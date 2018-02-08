all: skii

skii: lexer_util.c lexer.c main.c
	gcc -g -o skii lexer_util.c lexer.c main.c

lexer.c: lexer.re
	re2c -W -Werror -o lexer.c lexer.re

clean:
	rm -rf *.o lexer.c skii

t:
	./skii '/d/RBS_SIB_20.20.129_V1/Trace/SIB_MAC_M0162017-01-30_13-59-36.asc'

./test/test: lexer_util.c lexer.c ./test/munit.c ./test/test.c
	gcc -g -o ./test/test -I. -I./test/ lexer_util.c lexer.c ./test/test.c ./test/munit.c

test: ./test/test
	./test/test

.PHONY: all clean test t
