
CC = gcc
CCFLAGS = -Wall -Wextra -ansi -std=c99 -I./logging/ -I./argparse/ -I./include

GRAMMAR = grammar/date.y grammar/Events.y grammar/Header.y grammar/Triggerblock.y grammar/CanError.y
GRAMMAR += grammar/CanMessage.y grammar/CanStatistics.y grammar/LogEvents.y grammar/SystemVariables.y
GRAMMAR += grammar/TestStructureEvents.y grammar/Watermark.y grammar/Channel.y grammar/Dir.y grammar/Time.y grammar/MessageFlags.y
REGEX = regex/Events.re regex/Header.re regex/Month.re regex/Numerals.re regex/Punctuation.re regex/WeekDay.re regex/Whitespace.re
SCRIPTS = CogUtils.py Token.py TokenManager.py

vpath %.c src
vpath %.h include
vpath %.tpl templates

all: logilizer

debug: CCFLAGS += -g -pg
debug: logilizer

release: CCFLAGS += -Ofast -ffast-math -DNDEBUG -DNSANITY
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

./templates/lexer.c.re: ./templates/lexer.c.tpl.0 $(SCRIPTS)
	if [ -a $@ ]; then chmod 666 $@; fi;
	python -m cogapp -d -o $@ $<
	chmod 444 $@

./templates/lexer.c.tpl.0: ./templates/lexer.c.tpl $(REGEX) $(SCRIPTS)
	if [ -a $@ ]; then chmod 666 $@; fi;
	python -m cogapp -d -o $@ $<
	chmod 444 $@

./src/lexer.c: ./templates/lexer.c.re
	if [ -a $@ ]; then chmod 666 $@; fi;
	re2c -W -Werror --utf-8 -o $@ $<
	chmod 444 $@

./include/lexer_symbols.h: ./templates/lexer_symbols.h.tpl $(REGEX) $(SCRIPTS) ./include/parser.h ./src/lexer.c
	if [ -a $@ ]; then chmod 666 $@; fi;
	python -m cogapp -d -o $@ $<
	chmod 444 $@

./src/lexer_symbols.c: ./templates/lexer_symbols.c.tpl $(REGEX) $(SCRIPTS) ./include/parser.h ./src/lexer.c
	if [ -a $@ ]; then chmod 666 $@; fi;
	python -m cogapp -d -o $@ $<
	chmod 444 $@

./src/lexer_utils.c: ./templates/lexer_utils.c.tpl lexer_symbols.c lexer_symbols.h $(SCRIPTS)
	if [ -a $@ ]; then chmod 666 $@; fi;
	python -m cogapp -d -o $@ $<
	chmod 444 $@

./grammar/parser.y: ./templates/parser.y.tpl.0 $(SCRIPTS)
	if [ -a $@ ]; then chmod 666 $@; fi;
	python -m cogapp -d -o $@ $<
	chmod 444 $@

./templates/parser.y.tpl.0: ./templates/parser.y.tpl $(GRAMMAR) $(SCRIPTS)
	if [ -a $@ ]; then chmod 666 $@; fi;
	python -m cogapp -d -o $@ $<
	chmod 444 $@

./src/parser.c ./include/parser.h: ./grammar/parser.y ./templates/lempar.c lemon.exe
	if [ -a ./src/parser.c ]; then chmod 666 ./src/parser.c; fi;
	lemon -T./templates/lempar.c $<
	mv ./grammar/parser.c ./src/parser.c
	mv ./grammar/parser.h ./include/parser.h
	mv ./grammar/parser.out ./parser.out
	chmod 444 ./src/parser.c

lemon: lemon_tool_src/lemon.c
	$(CC) -Wall -Wextra -g -o $@ $<

clean:
	rm -rf *.o *.pyc logilizer.exe
	rm -rf tokens.dat ./templates/lexer.c.tpl.0 ./templates/parser.y.tpl.0
	rm -rf ./src/lexer.c  ./templates/lexer.c.re ./include/lexer_symbols.h ./src/lexer_symbols.c ./src/lexer_utils.c
	rm -rf ./src/parser.c ./grammar/parser.y parser.out ./include/parser.h parser.err
	rm -rf log.txt  SplintReport.txt gmon.out
	rm -rf ./grammar/parser.c ./grammar/parser.h ./grammar/parser.out

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
	logilizer -i ./samples/BASE_TS_00.txt
	logilizer -i ./samples/BEGIN_TRIGGER_00.txt
	logilizer -i ./samples/BEGIN_TRIGGER_01.txt
	logilizer -i ./samples/CANFD_00.txt
	logilizer -i ./samples/CANFD_01.txt
	logilizer -i ./samples/CANFD_02.txt
	logilizer -i ./samples/CAN_00.txt
	logilizer -i ./samples/CAN_01.txt
	logilizer -i ./samples/CAN_02.txt
	logilizer -i ./samples/CAN_EXT_00.txt
	logilizer -i ./samples/CAN_EXT_UDS_00.txt
	logilizer -i ./samples/CAN_STATUS_00.txt
	logilizer -i ./samples/CAN_STATUS_01.txt
	logilizer -i ./samples/COMMENT_00.txt
	logilizer -i ./samples/DATE_00.txt
	logilizer -i ./samples/END_TRIGGER_00.txt
	logilizer -i ./samples/ERROR_FRAME_00.txt
	logilizer -i ./samples/INTERNAL_EVENTS_00.txt
	logilizer -i ./samples/LOG_DIRECT_00.txt
	logilizer -i ./samples/NO_INTERNAL_EVENTS_00.txt
	logilizer -i ./samples/START_OF_MEASURE_00.txt
	logilizer -i ./samples/STATISTIC_00.txt
	logilizer -i ./samples/SV_00.txt
	logilizer -i ./samples/SV_01.txt
	logilizer -i ./samples/TFS_00.txt
	logilizer -i ./samples/WATERMARK_00.txt
	logilizer -i ./samples/WATERMARK_01.txt

.PHONY: all clean lextest lint

.INTERMEDIATE: ./templates/lexer.c.tpl.0 ./templates/parser.y.tpl.0

.DELETE_ON_ERROR: tokens.dat ./templates/lexer.c.re ./grammar/parser.y ./grammar/parser.c ./grammar/parser.h ./grammar/parser.out
