
#include "logilizer.h"

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>

#include "log.h"
#include "lexer.h"
#include "lemon.h"
#include "lemon_cfg.h"
#include "lexer_symbols.h"

/* Lexer */
#define CACHE_SIZE              8192
#define STILL_LEXING(token)     (VALID_TOKEN(token) && (token != TOKEN_END_OF_INPUT_STREAM))

/* Parser */
#ifndef NDEBUG
  #define PE_FNAME              "parser.err"
#endif

logilizer_t * logilizer_new(char * infile, char * outfile)
{
    logilizer_t * self = NULL;
    FILE * fp = NULL;
    
    if (access(infile, R_OK) == 0)
    {
        /* The file is readable */
        self = (logilizer_t *) malloc( sizeof(logilizer_t) );
        
        if (self == NULL)
        {
            /* Unable to allocate memory for ourself */
            log_fatal("Unable to allocate enough memory for the logilizer!\n");
        }
        else
        {
            /* Create the lexer */
            fp = fopen(infile, "r");
            
            if (fp == NULL)
            {
                /* TODO: Can this happen with the call to access? */
                log_error("Unable to open %s for reading because: %s\n", infile, strerror(errno));
            }
            
            assert(fp != NULL);
            self->lexer  = lexer_new(fp, CACHE_SIZE, YYMAXFILL);
            
            /* Create the parser */
            self->parser = ParseAlloc(malloc);
#ifndef NDEBUG
            self->parser_error_file = fopen(PE_FNAME, "w");
#endif
            /* Open the output file */
            if (strlen(outfile) == 0)
            {
                self->output = stdout;
            }
            else
            {
                fp = fopen(outfile, "w");
                
                if (fp == NULL)
                {
                    log_error("Unable to open %s for writing because: %s\n", outfile, strerror(errno));
                }
                
                assert(fp != NULL);
                self->output = fp;
            }
            
            self->state.output = self->output;
        }
    }
    else
    {
        /* the file is non-readable */
        log_error("Unable to read %s because: %s\n", infile, strerror(errno));
    }

    assert( self != NULL );
    
    return self;
}

void logilizer_destroy(logilizer_t * self)
{
    fclose(self->lexer->file);
#ifndef NDEBUG
    fclose(self->parser_error_file);
#endif
    fclose(self->output);
    
    if (self->parser != NULL)
    {
        ParseFree(self->parser, free);
    }
    lexer_destroy(self->lexer);
    free(self);
}

void logilizer_resolve(logilizer_t * self)
{
    tok_t   token;
    YYSTYPE yylval;
    
    /* Start with line 1 */
    self->lexer->line = 1;
    
    do
    {
        token  = lex(self->lexer);
        yylval = get_token_value(self->lexer, token);
        
        log_trace("%s(%d): %s", get_token_name(token), token, yylval);
        
        self->state.line = self->lexer->line;
        
        if (VALID_TOKEN(token))
        {
            /* Only pass valid tokens to the parser - this provides a smoother exit */
            Parse(self->parser, token, yylval, &(self->state));
#ifndef NDEBUG
            ParseTrace(self->parser_error_file, "");
#endif
        }
#ifndef NSANITY
        else
        {
            log_error("Received illegal token: %d", token);
        }
#endif
    } while (STILL_LEXING(token));
    
    /* A value of 0 for the second argument is a special flag to the parser to
       indicate that the end of input has been reached.
    */
    Parse(self->parser, 0, yylval, &(self->state));
    
    log_trace("Processed %d lines.", self->lexer->line);
}
