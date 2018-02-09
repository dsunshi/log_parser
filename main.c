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

        printf("-------------------------------------------------\n");
        printf("| file: %s\n", argv[1]);
        printf("-------------------------------------------------\n");
           do
            {
                token = lex(input);
                //printf("glorious %u lines!\n", count);
                //printf("token: %d", token);
                printf("%s ", get_token_name(token));
            } while(token > 0);
            
            printf("\n\n");
    }
    else
    {
        printf("no file provided!\n");
    }
    
    return 0;
}