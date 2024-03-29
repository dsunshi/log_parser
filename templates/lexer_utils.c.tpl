
#include "lexer.h"
#include "parser.h"
#include "log.h"

/* for get_token_name */
#include "lexer_symbols.h"

#include <assert.h>

/* Empty or blank token value for tokens that don't have a real value */
static const YYSTYPE BLANK = "";

static inline YYSTYPE create_str(iutf8_t * string, size_t length)
{
    YYSTYPE output = (YYSTYPE) malloc( sizeof(iutf8_t) * (length + 1) );
    
    assert(string != NULL);
    
    if (output != NULL)
    {
        memcpy( output, string, length );
        output[length] = '\0';
#ifndef NSANITY
        if (strlen(output) != length)
        {
            log_error("output length %d, does not match input length %d!", strlen(output), length);
        }
#endif
    }
#ifndef NSANITY
    else
    {
        log_error("Failed to duplicate: %s, length: %d", string, length);
    }
#endif
    
    assert(output != NULL);
    
    return output;
}

void free_token(YYSTYPE token)
{
    if (token == BLANK)
    {
        /* We don't want to call free on the static memory BLANK, so do nothing. */
    }
    else
    {
#ifndef NSANITY
        if (token == NULL)
        {
            log_error("Attempt to free a NULL token!");
        }
        if (strlen(token) == 0)
        {
            log_error("Attempt to free a token that is probably statically allocated!");
        }
#endif
        free(token);
    }
}

/* Create a lexer for the provided file */
yyinput_t * lexer_new(FILE * file, const size_t size, const size_t maxfill)
{
    yyinput_t * input = NULL;

    input = (yyinput_t *) malloc(sizeof(yyinput_t));

    if (input == NULL)
    {
        /* Unable to allocate enough memory for the lexer */
#ifndef NDEBUG
        log_error("Unable to allocate enough memory for the lexer!\n");
#endif
    }
    else
    {
        memset(input, 0x00, sizeof(yyinput_t));

        input->buffer = (iutf8_t *) malloc(sizeof(iutf8_t) * (size + maxfill));

        if (input->buffer == NULL)
        {
            /* Unable to allocate enough memory for the actual string buffer used by the lexer */
#ifndef NDEBUG
            log_error("Unable to allocate enough memory for the actual string buffer used by the lexer!\n");
#endif
        }
        else
        {
            memset(input->buffer, YYINVAILD, (size + maxfill));

            input->limit   = input->buffer + size;
            input->cursor  = input->limit;
            input->token   = input->limit;
            input->eof     = false;
            input->size    = size;
            input->maxfill = maxfill;
            input->file    = file;
            
            input->token_length = 0;
            input->parser_state = NULL;
        }
    }
    
    return input;
}

/* Get the value of the current token from within the lexers buffer.
 * 
 * This function is the main bottle neck for the *entire* application. It is called for each token, and as such is
 * called *extremly often*. Therefore, the number of if statements and even the order in which items are checked can
 * heavily influence the speed of the program.
 *
 * For this reason the function is tuned to check for the most common tokens first.
 */
YYSTYPE get_token_value(yyinput_t * input, tok_t token, size_t * yylength)
{
    const size_t length = input->cursor - input->token;
    
    *yylength = length;
    
    if (token == TOKEN_NUM)
    {
        /*[[[cog
        import CogUtils as tools

        tools.create_value_switch(num=True)
        ]]]*/
        /*[[[end]]]*/    
    }
    else
    {
        switch( token )
        {
            /*[[[cog
            import CogUtils as tools

            tools.create_value_switch()
            ]]]*/
            /*[[[end]]]*/
            default:
                return BLANK;
                break;
        }
    }
}

void lexer_destroy(yyinput_t * lexer)
{
    free(lexer->buffer);
    free(lexer);
}

/* Explaination of fill - taken directly from: http://re2c.org/examples/example_03.html
 *
 * The idea of YYFILL is fairly simple: the lexer is stuck upon the fact that (YYLIMIT - YYCURSOR) < n
 * and YYFILL must either invert this condition or stop lexing. A disaster will happen if YYFILL fails to provide
 * at least n characters, yet resumes lexing. Technically YYFILL must somehow "extend" the input by
 * at least n characters: after YYFILL, all input pointers must point to the exact same characters, except YYLIMIT,
 * which must be advanced at least n positions. Since we want to use a fixed amount of memory,
 * we have to shift buffer contents: discard characters that have already been lexed, move the
 * remaining characters to the beginning of the buffer, and fill the vacant space with new characters.
 * All the pointers must be decreased by the length of the discarded input,
 * except YYLIMIT (it must point at the end of buffer).
 */
bool fill(yyinput_t * input, const size_t need)
{
    const size_t remaining = input->token - input->buffer;
    size_t nread;
    
    if (input->eof != false)
    {
        return false;
    }
    else if (remaining < need)
    {
        return false;
    }
    else
    {
        /* buffer is the entire memory buffer
           token  is the location of the current char within buffer
           (limit - token) is the amount of remaining unprocessed data that will be move from the current
           location (token) to the start of the buffer so processing can continue.
         */
        memmove(input->buffer, input->token, input->limit - input->token);
        input->limit  -= remaining;
        input->cursor -= remaining;
        input->token  -= remaining;
        
        nread = fread(input->limit, (size_t) 1, remaining, input->file);
        input->limit += nread; 
        
        if (nread < remaining)
        {
            /* Either we've reached the end of the input file, or failed to read enough data to continue,
             * in both cases we're done here...
             */
            input->eof = true;
            memset(input->limit, YYINVAILD, input->maxfill);
            input->limit += input->maxfill;
        }
        
        return true;
    }
}

tok_t exit_success(yyinput_t * input)
{
    tok_t result = LEXER_EXIT_ERROR;

    if (input->maxfill == ((size_t) (input->limit - input->token)))
    {
        /* The current token is exaclty at the end of the input buffer. So if we have lexed to an end we have
         * sucessfully lexed the entire input.
         */
        result = TOKEN_END_OF_INPUT_STREAM;
    }
    else
    {
        
    }
    
    return result;
}