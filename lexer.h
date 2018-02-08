
#ifndef __LEXER_H_
#define __LEXER_H_

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

typedef struct input
{
    char * buffer;      /* Character buffer of size: (size + maxfill) */
    char * limit;       /* The end of the input */
    char * cursor;      /* Current character - used during lexing */
    char * token;       /* Current character - used for reading from the input stream */
    char * marker;      /* Backtrack position - i.e. backup input position used to restore cursor */
    bool   eof;         /* Flag indicating if the End Of File has been reached */
    size_t size;        /* Size of the input buffer */
    size_t maxfill;     /* Additional padding bytes for the input string */
    int    state;       /* */
    FILE * file;        /* File to lex */
} yyinput_t;

/* Additional padding bytes for the input string.
   NOTE: This is NOT the size of the input string buffer.
*/
#define YYMAXFILL 64

/* Character that does not form a valid lexeme or lexeme suffix. Exists only between limit and maxfill. */
#define YYINVAILD 0x00

#define LEXER_FILL_ERROR (-1)

#ifdef __cplusplus
extern "C" {
#endif

yyinput_t * create_lexer(FILE * file, const size_t size, const size_t maxfill);
void destroy_lexer(yyinput_t * lexer);

bool fill(yyinput_t * input, const size_t need);

int  lex(yyinput_t * input);
bool exit_success(yyinput_t * input);

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif