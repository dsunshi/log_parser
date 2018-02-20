#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lexer.h"
#include "lemon.h"
#include "lemon_cfg.h"
#include "lexer_symbols.h"

int main(int argc, char **argv)
{

    yyinput_t * input = NULL;
    YYSTYPE yylval;
    void * pParser;
    ParserState state;
    
    FILE * err;

    tok_t token;

    if (argc > 1)
    {
        input   = create_lexer(fopen(argv[1], "r"), 4096, YYMAXFILL);
        pParser = ParseAlloc(malloc);
//        yylval.buffer = (char *) malloc( sizeof(char) * 120 );
        err = fopen("parser.err", "w");
        printf("-------------------------------------------------\n");
        printf("| FILE: %s\n", argv[1]);
        printf("-------------------------------------------------\n");
        do
        {
            token = lex(input);
            //printf("%d ", token);
            yylval = get_token_value(input, token);
            //printf("token value: %s ", yylval.buffer);
            //printf("%s(%d) ", get_token_name(token), token);
            if (token > 0)
            {
                /* Only pass valid tokens to the parser - this provides a smoother exit */
                Parse(pParser, token, yylval, &state);
                ParseTrace(err, "");
            }   
        } while ((token > 0) && (token != TOKEN_END_OF_INPUT_STREAM));
         
        /* A value of 0 for the second argument is a special flag to the parser to
           indicate that the end of input has been reached.
         */
        Parse(pParser, 0, yylval, &state);
         
        ParseFree(pParser, free);
        destroy_lexer(input);
        
        printf("-------------------------------------------------\n");
        printf("|                      EOF                       |\n");
        printf("-------------------------------------------------\n");
    }
    else
    {
        printf("no file provided!\n");
    }
    
    return 0;
}