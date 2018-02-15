all: fasst

fasst: lexer_utils.c lexer.c main.c lexer_symbols.h lexer_symbols.c parser.c
	gcc -Wall -Wextra -g -o fasst lexer_utils.c lexer_symbols.c lexer.c main.c parser.c

lexer.re: lexer.tpl.0
	python -m cogapp -d -o lexer.re lexer.tpl.0

lexer.tpl.0: lexer.tpl Header.re Month.re Numerals.re Punctuation.re Weekday.re Whitespace.re
	python -m cogapp -d -o lexer.tpl.0 lexer.tpl

lexer.c: lexer.re 
	re2c -W -Werror --utf-8 -o lexer.c lexer.re

lexer_symbols.h: lexer_symbols.h.tpl Header.re Month.re Numerals.re Punctuation.re Weekday.re Whitespace.re parser.c
	python -m cogapp -d -o lexer_symbols.h lexer_symbols.h.tpl

lexer_symbols.c: lexer_symbols.c.tpl Header.re Month.re Numerals.re Punctuation.re Weekday.re Whitespace.re parser.c
	python -m cogapp -d -o lexer_symbols.c lexer_symbols.c.tpl

parser.y: parser.y.tpl date.y
	python -m cogapp -d -o parser.y parser.y.tpl

parser.c: parser.y lempar.c lemon.exe
	lemon parser.y
    
lemon.exe: lemon_tool_src/lemon.c
	gcc -Wall -Wextra -g -o lemon lemon_tool_src/lemon.c

clean:
	rm -rf *.o *.pyc lexer.c fasst.exe lexer.re tokens.dat lexer.tpl.0 lexer_symbols.h lexer_symbols.c parser.c parser.y parser.out parser.h

lextest: fasst  
	fasst samples/BASE_TS_00.txt
	fasst samples/BEGIN_TRIGGER_00.txt
	fasst samples/BEGIN_TRIGGER_01.txt
	fasst samples/CAN_00.txt
	fasst samples/CAN_01.txt
	fasst samples/CAN_02.txt
	fasst samples/CAN_STATUS_00.txt
	fasst samples/CAN_STATUS_01.txt
	fasst samples/COMMENT_00.txt
	fasst samples/DATE_00.txt
	fasst samples/END_TRIGGER_00.txt
	fasst samples/ERROR_FRAME_00.txt
	fasst samples/INTERNAL_EVENTS_00.txt
	fasst samples/LOG_DIRECT_00.txt
	fasst samples/NO_INTERNAL_EVENTS_00.txt
	fasst samples/START_OF_MEASURE_00.txt
	fasst samples/STATISTIC_00.txt
	fasst samples/SV_00.txt
	fasst samples/TFS_00.txt
	fasst samples/WATERMARK_00.txt
	fasst samples/WATERMARK_01.txt

.PHONY: all clean lextest
