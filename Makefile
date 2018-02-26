all: logilizer

logilizer: lexer_utils.c lexer.c main.c lexer_symbols.h lexer_symbols.c parser.c ./logging/log.c ./argparse/argparse.c logilizer.c
	gcc -Wall -Wextra -g -o logilizer -I./argparse -I./logging lexer_utils.c lexer_symbols.c lexer.c main.c parser.c ./logging/log.c ./argparse/argparse.c logilizer.c

lexer.c.re: lexer.c.tpl.0
	python -m cogapp -d -o lexer.c.re lexer.c.tpl.0

lexer.c.tpl.0: lexer.c.tpl ./regex/*.re
	python -m cogapp -d -o lexer.c.tpl.0 lexer.c.tpl

lexer.c: lexer.c.re 
	re2c -W -Werror --utf-8 -o lexer.c lexer.c.re

lexer_symbols.h: lexer_symbols.h.tpl ./regex/*.re parser.c lexer.c
	python -m cogapp -d -o lexer_symbols.h lexer_symbols.h.tpl

lexer_symbols.c: lexer_symbols.c.tpl ./regex/*.re parser.c lexer.c
	python -m cogapp -d -o lexer_symbols.c lexer_symbols.c.tpl

lexer_utils.c: lexer_utils.c.tpl lexer_symbols.c lexer_symbols.h
	python -m cogapp -d -o lexer_utils.c lexer_utils.c.tpl

parser.y: parser.y.tpl ./grammar/*.y
	python -m cogapp -d -o parser.y parser.y.tpl

parser.c: parser.y lempar.c lemon.exe
	lemon parser.y
    
lemon.exe: lemon_tool_src/lemon.c
	gcc -Wall -Wextra -g -o lemon lemon_tool_src/lemon.c

clean:
	rm -rf *.o *.pyc lexer.c logilizer.exe lexer.c.re tokens.dat lexer.c.tpl.0 lexer_symbols.h lexer_symbols.c parser.c parser.y parser.out parser.h parser.err log.txt lexer_utils.c

debug:
	gdb -ex=r --args logilizer.exe -i samples/MIXED.txt

lextest: logilizer  
	logilizer samples/BASE_TS_00.txt
	logilizer samples/BEGIN_TRIGGER_00.txt
	logilizer samples/BEGIN_TRIGGER_01.txt
	logilizer samples/CAN_00.txt
	logilizer samples/CAN_01.txt
	logilizer samples/CAN_02.txt
	logilizer samples/CAN_STATUS_00.txt
	logilizer samples/CAN_STATUS_01.txt
	logilizer samples/COMMENT_00.txt
	logilizer samples/DATE_00.txt
	logilizer samples/END_TRIGGER_00.txt
	logilizer samples/ERROR_FRAME_00.txt
	logilizer samples/INTERNAL_EVENTS_00.txt
	logilizer samples/LOG_DIRECT_00.txt
	logilizer samples/NO_INTERNAL_EVENTS_00.txt
	logilizer samples/START_OF_MEASURE_00.txt
	logilizer samples/STATISTIC_00.txt
	logilizer samples/SV_00.txt
	logilizer samples/TFS_00.txt
	logilizer samples/WATERMARK_00.txt
	logilizer samples/WATERMARK_01.txt

.PHONY: all clean lextest debug
