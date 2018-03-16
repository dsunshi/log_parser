all: logilizer

logilizer: main.o parser.o lexer_symbols.o log.o argparse.o logilizer.o lexer.o lexer_utils.o
	gcc -Wall -Wextra -ansi -std=c99 -g -o logilizer  main.o parser.o lexer_symbols.o log.o argparse.o logilizer.o lexer.o lexer_utils.o

main.o: main.c logging/log.h logilizer.h lemon_cfg.h lexer.h argparse/argparse.h lemon.h lexer_symbols.h
	gcc -Wall -Wextra -ansi -std=c99 -g -c -I./logging/ -I./argparse/ main.c

parser.o: parser.c lemon_cfg.h logging/log.h lexer.h
	gcc -Wall -Wextra -ansi -std=c99 -g -c -I./logging/ parser.c

lexer_symbols.o: lexer_symbols.c lexer.h lemon_cfg.h lexer_symbols.h
	gcc -Wall -Wextra -ansi -std=c99 -g -c lexer_symbols.c

log.o: ./logging/log.c
	gcc -Wall -Wextra -ansi -std=c99 -g -c ./logging/log.c

argparse.o: ./argparse/argparse.c
	gcc -Wall -Wextra -ansi -std=c99 -g -c ./argparse/argparse.c

logilizer.o: logilizer.c logilizer.h lemon_cfg.h lexer.h logging/log.h lemon.h lexer_symbols.h
	gcc -Wall -Wextra -ansi -std=c99 -g -c -I./logging/ logilizer.c

lexer.o: lexer.c lexer.h lemon_cfg.h lexer_symbols.h
	gcc -Wall -Wextra -ansi -std=c99 -g -c lexer.c

lexer_utils.o: lexer_utils.c lexer.h lemon_cfg.h parser.h lexer_symbols.h
	gcc -Wall -Wextra -ansi -std=c99 -g -c lexer_utils.c

lexer.c.re: lexer.c.tpl.0
	-chmod 666 lexer.c.re
	python -m cogapp -d -o lexer.c.re lexer.c.tpl.0
	chmod 444 lexer.c.re

lexer.c.tpl.0: lexer.c.tpl ./regex/*.re
	-chmod 666 lexer.c.tpl.0
	python -m cogapp -d -o lexer.c.tpl.0 lexer.c.tpl
	chmod 444 lexer.c.tpl.0

lexer.c: lexer.c.re
	-chmod 666 lexer.c
	re2c -W -Werror --utf-8 -o lexer.c lexer.c.re
	chmod 444 lexer.c

lexer_symbols.h: lexer_symbols.h.tpl ./regex/*.re parser.c lexer.c
	-chmod 666 lexer_symbols.h
	python -m cogapp -d -o lexer_symbols.h lexer_symbols.h.tpl
	chmod 444 lexer_symbols.h

lexer_symbols.c: lexer_symbols.c.tpl ./regex/*.re parser.c lexer.c
	-chmod 666 lexer_symbols.c
	python -m cogapp -d -o lexer_symbols.c lexer_symbols.c.tpl
	chmod 444 lexer_symbols.c

lexer_utils.c: lexer_utils.c.tpl lexer_symbols.c lexer_symbols.h
	-chmod 666 lexer_utils.c
	python -m cogapp -d -o lexer_utils.c lexer_utils.c.tpl
	chmod 444 lexer_utils.c

parser.y: parser.y.tpl ./grammar/*.y
	-chmod 666 parser.y
	python -m cogapp -d -o parser.y parser.y.tpl
	chmod 444 parser.y

parser.c: parser.y lempar.c lemon.exe
	-chmod 666 parser.y
	lemon parser.y
	chmod 444 parser.c

lemon.exe: lemon_tool_src/lemon.c
	gcc -Wall -Wextra -g -o lemon lemon_tool_src/lemon.c

clean:
	rm -rf *.o *.pyc lexer.c logilizer.exe lexer.c.re tokens.dat lexer.c.tpl.0 lexer_symbols.h lexer_symbols.c parser.c parser.y parser.out parser.h parser.err log.txt lexer_utils.c SplintReport.txt

debug:
	gdb -ex=r --args logilizer.exe -i samples/MIXED.txt

lint:
	-splint -I./logging/ -I./argparse/ -systemdirerrors -preproc main.c > SplintReport.txt
	-splint -I./logging/ -I./argparse/ -systemdirerrors -preproc lexer_symbols.c >> SplintReport.txt
	-splint -I./logging/ -I./argparse/ -systemdirerrors -preproc lexer_utils.c >> SplintReport.txt
	-splint -I./logging/ -I./argparse/ -systemdirerrors -preproc parser.c >> SplintReport.txt
	-splint -I./logging/ -I./argparse/ -systemdirerrors -preproc logilizer.c >> SplintReport.txt
	-splint -I./logging/ -I./argparse/ -systemdirerrors -preproc lexer.c >> SplintReport.txt

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

.PHONY: all clean lextest debug lint
