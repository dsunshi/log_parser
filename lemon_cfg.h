#ifndef __LEMON_CFG_H_
#define __LEMON_CFG_H_

//#include "lexer.h"

typedef struct
{
    int token;
    //iutf8_t * buffer;
    char * buffer;
} YYSTYPE;

typedef struct
{
    int state;
} ParserState;

#endif // LEMON_CFG_H_
