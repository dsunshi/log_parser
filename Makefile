
CC = gcc
CCFLAGS = -Wall -Wextra -ansi -std=c99 -I./logging/ -I./argparse/

all: logilizer

debug: CCFLAGS += -g -pg
debug: logilizer

release: CCFLAGS += -Ofast -DNDEBUG -DNSANITY
release: logilizer

logilizer: main.o parser.o lexer_symbols.o log.o argparse.o logilizer.o lexer.o lexer_utils.o
	$(CC) $(CCFLAGS) $^ -o $@

main.o: main.c logging/log.h logilizer.h lemon_cfg.h lexer.h argparse/argparse.h lemon.h lexer_symbols.h
	$(CC) $(CCFLAGS) -c $<

parser.o: parser.c lemon_cfg.h logging/log.h lexer.h
	$(CC) $(CCFLAGS) -c $<

lexer_symbols.o: lexer_symbols.c lexer.h lemon_cfg.h lexer_symbols.h
	$(CC) $(CCFLAGS) -c $<

log.o: ./logging/log.c
	$(CC) $(CCFLAGS) -c $<

argparse.o: ./argparse/argparse.c
	$(CC) $(CCFLAGS) -c $<

logilizer.o: logilizer.c logilizer.h lemon_cfg.h lexer.h logging/log.h lemon.h lexer_symbols.h
	$(CC) $(CCFLAGS) -c $<

lexer.o: lexer.c lexer.h lemon_cfg.h lexer_symbols.h
	$(CC) $(CCFLAGS) -c $<

lexer_utils.o: lexer_utils.c lexer.h lemon_cfg.h parser.h lexer_symbols.h
	$(CC) $(CCFLAGS) -c $<

lexer.c.re: lexer.c.tpl.0 CogUtils.py Token.py TokenManager.py
	if [ -a $@ ]; then chmod 666 $@; fi;
	python -m cogapp -d -o $@ $<
	chmod 444 $@

lexer.c.tpl.0: lexer.c.tpl ./regex/*.re CogUtils.py Token.py TokenManager.py
	if [ -a $@ ]; then chmod 666 $@; fi;
	python -m cogapp -d -o $@ $<
	chmod 444 $@

lexer.c: lexer.c.re
	if [ -a $@ ]; then chmod 666 $@; fi;
	re2c -W -Werror --utf-8 -o lexer.c $<
	chmod 444 lexer.c

lexer_symbols.h: lexer_symbols.h.tpl ./regex/*.re parser.h lexer.c CogUtils.py Token.py TokenManager.py
	if [ -a $@ ]; then chmod 666 $@; fi;
	python -m cogapp -d -o $@ $<
	chmod 444 $@

lexer_symbols.c: lexer_symbols.c.tpl ./regex/*.re parser.h lexer.c CogUtils.py Token.py TokenManager.py
	if [ -a $@ ]; then chmod 666 $@; fi;
	python -m cogapp -d -o $@ $<
	chmod 444 $@

lexer_utils.c: lexer_utils.c.tpl lexer_symbols.c lexer_symbols.h CogUtils.py Token.py TokenManager.py
	if [ -a $@ ]; then chmod 666 $@; fi;
	python -m cogapp -d -o $@ $<
	chmod 444 $@

parser.y: parser.y.tpl.0 CogUtils.py Token.py TokenManager.py
	if [ -a $@ ]; then chmod 666 $@; fi;
	python -m cogapp -d -o $@ $<
	chmod 444 $@
    
parser.y.tpl.0: parser.y.tpl ./grammar/*.y CogUtils.py Token.py TokenManager.py Token.py TokenManager.py
	if [ -a $@ ]; then chmod 666 $@; fi;
	python -m cogapp -d -o $@ $<
	chmod 444 $@

parser.c parser.h: parser.y lempar.c lemon.exe
	if [ -a parser.c ]; then chmod 666 parser.c; fi;
	lemon $<
	chmod 444 parser.c

lemon: lemon_tool_src/lemon.c
	$(CC) -Wall -Wextra -g -o $@ $<

clean:
	rm -rf *.o *.pyc logilizer.exe
	rm -rf tokens.dat lexer.c.tpl.0 parser.y.tpl.0
	rm -rf lexer.c  lexer.c.re lexer_symbols.h lexer_symbols.c lexer_utils.c
	rm -rf parser.c parser.y parser.out parser.h parser.err
	rm -rf log.txt  SplintReport.txt gmon.out

gdb: debug
	gdb -ex=r --args logilizer.exe -i samples/TFS_00.txt

lint:
	-splint -I./logging/ -I./argparse/ -systemdirerrors -preproc main.c > SplintReport.txt
	-splint -I./logging/ -I./argparse/ -systemdirerrors -preproc lexer_symbols.c >> SplintReport.txt
	-splint -I./logging/ -I./argparse/ -systemdirerrors -preproc lexer_utils.c >> SplintReport.txt
	-splint -I./logging/ -I./argparse/ -systemdirerrors -preproc parser.c >> SplintReport.txt
	-splint -I./logging/ -I./argparse/ -systemdirerrors -preproc logilizer.c >> SplintReport.txt
	-splint -I./logging/ -I./argparse/ -systemdirerrors -preproc lexer.c >> SplintReport.txt

lextest: logilizer
	logilizer -i samples/BASE_TS_00.txt
	logilizer -i samples/BEGIN_TRIGGER_00.txt
	logilizer -i samples/BEGIN_TRIGGER_01.txt
	logilizer -i samples/CAN_00.txt
	logilizer -i samples/CAN_01.txt
	logilizer -i samples/CAN_02.txt
	logilizer -i samples/CAN_STATUS_00.txt
	logilizer -i samples/CAN_STATUS_01.txt
	logilizer -i samples/COMMENT_00.txt
	logilizer -i samples/DATE_00.txt
	logilizer -i samples/END_TRIGGER_00.txt
	logilizer -i samples/ERROR_FRAME_00.txt
	logilizer -i samples/INTERNAL_EVENTS_00.txt
	logilizer -i samples/LOG_DIRECT_00.txt
	logilizer -i samples/NO_INTERNAL_EVENTS_00.txt
	logilizer -i samples/START_OF_MEASURE_00.txt
	logilizer -i samples/STATISTIC_00.txt
	logilizer -i samples/SV_00.txt
	logilizer -i samples/TFS_00.txt
	logilizer -i samples/WATERMARK_00.txt
	logilizer -i samples/WATERMARK_01.txt

.PHONY: all clean lextest debug lint

.INTERMEDIATE: lexer.c.tpl.0 parser.y.tpl.0

.DELETE_ON_ERROR: tokens.dat lexer.c.re parser.y
