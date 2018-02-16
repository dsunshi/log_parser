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

    int token;

    if (argc > 1)
    {
        input   = create_lexer(fopen(argv[1], "r"), 4096, YYMAXFILL);
        pParser = ParseAlloc(malloc);
//        yylval.buffer = (char *) malloc( sizeof(char) * 120 );
        err = fopen("parser.err", "w");
        printf("-------------------------------------------------\n");
        printf("| file: %s\n", argv[1]);
        printf("-------------------------------------------------\n");
        do
        {
            token = lex(input);
            yylval.buffer = (char *) malloc( sizeof(char) * 120 );
            //printf("%d ", token);
            get_token_value(input, &yylval); 
            //printf("token value: %s ", yylval.buffer);
            //printf("%s(%d) ", get_token_name(token), token);
            if (token > 0)
            {
                /* Only pass valid tokens to the parser - this provides a smoother exit */
                Parse(pParser, token, yylval, &state);
                ParseTrace(err, "");
            }   
        } while ((token > 0) && (token != TOKEN_END));
         
        /* A value of 0 for the second argument is a special flag to the parser to
           indicate that the end of input has been reached.
         */
        Parse(pParser, 0, yylval, &state);
         
        ParseFree(pParser, free);
         
        printf("\n\n");
    }
    else
    {
        printf("no file provided!\n");
    }
    
    return 0;
}