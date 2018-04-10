
#ifndef __LEXER_H_
#define __LEXER_H_

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

/* Needed for YYSTYPE used by get_token_value */
#include "lemon_cfg.h"

/* Needed for NUM_TOKENS*/
#include "lexer_symbols.h"

typedef unsigned char iutf8_t;
typedef int tok_t;

typedef struct input
{
    iutf8_t * buffer;      /* Character buffer of size: (size + maxfill) */
    iutf8_t * limit;       /* The end of the input */
    iutf8_t * cursor;      /* Current character - used during lexing */
    iutf8_t * token;       /* Current character - used for reading from the input stream */
    iutf8_t * marker;      /* Backtrack position - i.e. backup input position used to restore cursor */
    bool      eof;         /* Flag indicating if the End Of File has been reached */
    size_t    size;        /* Size of the input buffer */
    size_t    maxfill;     /* Additional padding bytes for the input string */
    //int       state;       /* */
    FILE *    file;        /* File to lex */
    size_t    line;        /* Line number in the file */
    size_t    token_length;
    ParserState * parser_state;   /* User-defined state of the parser */
    bool msg_duration_found;
} yyinput_t;

/* Additional padding bytes for the input string.
   NOTE: This is NOT the size of the input string buffer.
*/
#define YYMAXFILL 64

/* Character that does not form a valid lexeme or lexeme suffix. Exists only between limit and maxfill. */
#define YYINVAILD 0x00

#define LEXER_FILL_ERROR (-1)
#define LEXER_EXIT_ERROR (-2)

#define VALID_TOKEN(token)  ((token > 0) && (token <= NUM_TOKENS))

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif