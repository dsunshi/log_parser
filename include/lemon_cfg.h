#ifndef __LEMON_CFG_H_
#define __LEMON_CFG_H_

#include <stdio.h>
#include <stdint.h>

typedef char * YYSTYPE;

typedef struct
{
    FILE *   output;
    size_t   line;
    uint32_t event_type;
} ParserState;

#endif // LEMON_CFG_H_
