#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lexer.h"
#include "lexer_symbols.h"

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
                //printf("token: %d", token);
                printf("%s ", get_token_name(token));
            } while(token > 0);
    }
    else
    {
        printf("no file provided!\n");
    }

    
    return 0;
}