#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "lexer.h"
#include "lexer_symbols.h"

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
            
            //[[[cog
            //  import cog
            //  import CogUtils as tools
            //  import TokenManager as tm
            //  from Token import Token
            //
            //  tools.create_token("*", "UNKOWN")
            //
            //  cog.outl("%s\t\t\t{ return %s; }" % ("\"\\x00\"", "exit_success(input)"))
            //  tm.add(Token("end_of_input_stream", "END_OF_INPUT_STREAM"))
            //
            //  cog.out("\n")
            //
            //  cog.out( tools.readfiles(["Header.re", "Month.re", "Numerals.re", "Punctuation.re", "Weekday.re"]) )
            //  cog.out( tools.readfiles(["Whitespace.re", "Events.re"]) )
            //
            //]]]
            //[[[end]]]
            
            // If the above imports don't find a keyword than we've found an identifer.
            identifier = [a-zA-Z_][a-zA-Z_0-9]*;
            //[[[cog
            //  import cog
            //  import CogUtils as tools
            //
            //  tools.create_token("identifier", "IDENTIFIER", 256)
            //
            //]]]
            //[[[end]]]
        */
}