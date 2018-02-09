#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "lexer.h"
#include "lexer_symbols.h"

/*[[[cog
import cog

TOKEN_PREFIX = "TOKEN_"

def ret_token(name, symbol, prefix=TOKEN_PREFIX):
    cog.outl( "%s\t\t\t{ return %s%s; }"    % (name, prefix, symbol) )
    
def ret_string(name, symbol, prefix=TOKEN_PREFIX):
    cog.outl( "\"%s\"\t\t\t{ return %s%s; }" % (name, prefix, symbol) )
]]]*/
/*[[[end]]]*/

int lex(yyinput_t * input)
{

        input->token = input->cursor;
        //printf("cursor: |%s|\n", input->cursor);

        /*!re2c
            re2c:define:YYCTYPE      = iutf8_t;
            re2c:define:YYCURSOR     = input->cursor;
            re2c:define:YYLIMIT      = input->limit;
            re2c:define:YYMARKER     = input->marker;
            re2c:define:YYFILL       = "if (fill(input, @@) == false) return LEXER_FILL_ERROR;";
            re2c:define:YYFILL:naked = 1;

            end = "\x00";
            
            //[[[cog
            //  import cog
            //  import CogUtils as tools
            //
            //  ret_token("*",      "UNKOWN")
            //  ret_token("end",     "exit_success(input)", prefix="")
            //  cog.out("\n")
            //
            //  cog.out( tools.readfiles(["Header.re", "Month.re", "Numerals.re", "Punctuation.re", "Weekday.re"]) )
            //  #cog.out( tools.readfiles(["Weekday.re"]) )
            //
            //]]]
            //[[[end]]]
            
        */
}