%token_prefix TOKEN_

%token_type        {     YYSTYPE     }
%token_destructor  { free_token($$); }

%fallback IDENTIFIER CAN.
%fallback HEX D E B.

%default_type       {  YYSTYPE  }
%default_destructor { free($$); }

%left SPACE.

%extra_argument { ParserState *state }

%include {
#include "lemon_cfg.h"
#include "log.h"
#include "lexer.h"
/* yy_pop_parser_stack requires assert */
//#include <assert.h>
#define assert(x) ((void)0)
#define UNUSED(x) (void)(x)
#include <stdio.h>
#include <stdlib.h>
}

%syntax_error {
    UNUSED(yymajor);
    UNUSED(yyminor);
    /* Clear the stack so we can shift in 'error's until a NEWLINE and hopefully recover */
    while( yypParser->yytos>yypParser->yystack ) yy_pop_parser_stack(yypParser);
#ifndef NDEBUG
    int n;
    int i;
  
    n = sizeof(yyTokenName) / sizeof(yyTokenName[0]);
    
    log_error("Expected: ");
    
    for (i = 0; i < n; i++)
    {
            int a = yy_find_shift_action(yypParser, (YYCODETYPE)i);
            
            if (a < YYNSTATE + YYNRULE)
            {
                log_error("%s ", yyTokenName[i]);
                if ((i > 0) && (n > 1) && (i < (n-2)))
                {
                        log_error("or ");
                }
            }
            
    }
    log_error("\n");
#endif
    log_error("Syntax Error!\n");
}

%parse_failure {
    log_error("Giving up. Parser is hopelessly lost...\n");
}

%stack_overflow {
    log_error("Giving up. Stack overflow\n");
}

%start_symbol log

log ::= in END_OF_INPUT_STREAM.
in  ::= in date.
in  ::= in base SPACE timestamps.
in  ::= in logging.
in  ::= in version.
in  ::= in begin_triggerblock.
in  ::= in start_of_measurement.
in  ::= in can_error_event.
in  ::= in end_triggerblock.
in  ::= in can_statistic_event.
in  ::= in log_trigger_event.
in  ::= in log_direct_event.
in  ::= in can_message.
in  ::= in NEWLINE.
in  ::= error NEWLINE.
in  ::= .

num(n) ::= DEC(d).
{
    n = (char *) malloc( sizeof(char) * strlen(d) );
    snprintf(n, strlen(d), "%s", d);
}

num(n) ::= HEX(d).
{
    n = (char *) malloc( sizeof(char) * strlen(d) );
    snprintf(n, strlen(d), "%s", d);
}

/*[[[cog
  import cog
  import CogUtils as tools

  cog.out( tools.readfiles(["date.y", "Header.y", "Triggerblock.y", "Events.y"]) )
]]]*/
/*[[[end]]]*/
