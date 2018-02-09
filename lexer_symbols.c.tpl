
#include "lexer.h"
#include "lexer_symbols.h"

static const char * const LEXER_SYMBOL_TABLE[] =
{
/*[[[cog
import CogUtils as tools

tools.create_table()
]]]*/
/*[[[end]]]*/
};


const char * get_token_name(const int token_id)
{
    if (token_id < 0)
    {
        return "ERROR";
    }
    else if (token_id == 0)
    {
        return "END";
    }
    else
    {
        return LEXER_SYMBOL_TABLE[token_id - 1];
    }
}