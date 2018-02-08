#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "lexer.h"

int lex(yyinput_t * input)
{

        input->token = input->cursor;
        //printf("cursor: |%s|\n", input->cursor);

        /*!re2c
            re2c:define:YYCTYPE      = char;
            re2c:define:YYCURSOR     = input->cursor;
            re2c:define:YYLIMIT      = input->limit;
            re2c:define:YYMARKER     = input->marker;
            re2c:define:YYFILL       = "if (fill(input, @@) == flase) return LEXER_FILL_ERROR;";
            re2c:define:YYFILL:naked = 1;

            end = "\x00";
            
            //[[[cog
            //  import cog
            //  import CogUtils as tools
            //  cog.out( tools.readfile("Weekday.re") )
            //]]]
            //[[[end]]]
        */
}