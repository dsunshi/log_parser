#ifndef __LEMON_CFG_H_
#define __LEMON_CFG_H_

#include <stdio.h>

typedef char * YYSTYPE;

typedef struct
{
    FILE * output;
    size_t line;
} ParserState;

#endif // LEMON_CFG_H_
