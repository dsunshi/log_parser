#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lexer.h"

const char * const TEST_LUT[] = {
"XR",
"XD",
"WARNING",
"TXERR",
"TX",
"TRIGGERBLOCK",
"TRIGGER",
"TRANSMERR",
"TIMESTAMPS",
"TFS",
"TEST",
"SV",
"STOP",
"STATUS",
"STATISTIC",
"STARTED",
"START",
"RXERR",
"RX",
"RELATIVE",
"R",
"QUEUE",
"POSITION",
"PM",
"PASSIVE",
"OF",
"O",
"NO",
"MS",
"MODULE",
"MEASUREMENT",
"LOWWATERMARK",
"LOGGED",
"LOG",
"LI",
"LEVEL",
"LENGTH",
"INTERNAL",
"ID",
"HIGHWATERMARK",
"HEX",
"FLAGS",
"FINISHED",
"FAILED",
"EVENTS",
"EVENT",
"ERRORFRAME",
"ERROR",
"END",
"ECC",
"E",
"DLC",
"DIRECT",
"DEC",
"DATE",
"DATA",
"CODEEXT",
"CODE",
"CHIP",
"CHECKSUM",
"CASE",
"CANFD",
"CAN",
"BITCOUNT",
"BEGIN",
"BASE",
"B",
"AM",
"ACTIVE",
"ABSOLUTE",
"=",
"]",
"[",
":",
".",
",",
")",
"(",
"!",
"%",
"-",
"CONST",
" "
};


int main(int argc, char **argv)
{

    yyinput_t * input = NULL;

    int token;

    if (argc > 1)
    {
        input = create_lexer(fopen(argv[1], "r"), 4096, YYMAXFILL);

           do
            {
                token = lex(input);
                //printf("glorious %u lines!\n", count);
                printf("token: %d\n", token);
                //printf("%s ", TEST_LUT[token]);
            } while(token > 0);
    }
    else
    {
        printf("no file provided!\n");
    }

    
    return 0;
}