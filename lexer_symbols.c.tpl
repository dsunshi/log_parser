
#include "lexer.h"
#include "lexer_symbols.h"

typedef struct
{
    char * name;
    int    id;
} symbol_t;

static symbol_t LEXER_SYMBOL_TABLE[NUM_TOKENS] =
{
/*[[[cog
import CogUtils as tools

tools.create_table()
]]]*/
/*[[[end]]]*/
};


const char * get_token_name(const int token_id)
{
    int index = 0;
    
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
        for (index = 0; index < NUM_TOKENS; index++)
        {
            if (LEXER_SYMBOL_TABLE[index].id == token_id)
            {
                return LEXER_SYMBOL_TABLE[index].name;
            }
        }
        
        return "OVERFLOW";
    }
}