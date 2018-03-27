
#ifndef __TOKEN_H_
#define __TOKEN_H_

/* Needed for YYSTYPE used by get_token_value */
#include "lemon_cfg.h"

/* for tok_t */
#include "lexer.h"

typedef struct logilizer
{
    /* Lexer */
    yyinput_t * lexer;
    
    /* Parser */
    void * parser;
    FILE * parser_error_file;
    ParserState state;
    
    FILE * output;
} logilizer_t;

#ifdef __cplusplus
extern "C" {
#endif

logilizer_t * logilizer_new(char * infile, char * outfile);
void logilizer_destroy(logilizer_t * self);
void logilizer_resolve(logilizer_t * self);

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif