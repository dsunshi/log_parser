
#include "lexer.h"
#include "lexer_symbols.h"

typedef struct
{
    char * name;
    int    id;
} symbol_t;

#define SIZE_OF_OVERFLOW_STR    15

static char overflow_text[SIZE_OF_OVERFLOW_STR];

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
        return "UNDEFINED TOKEN ID";
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
        
        snprintf(overflow_text, SIZE_OF_OVERFLOW_STR, "OVERFLOW (%d)", token_id);
        
        return overflow_text;
    }
}