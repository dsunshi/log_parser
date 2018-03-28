%token_prefix TOKEN_

%token_type        {     YYSTYPE     }
%token_destructor  { free_token($$); }

%fallback IDENTIFIER CAN.
%fallback NUM D E B.

%default_type       {  YYSTYPE  }
%default_destructor { free($$); }

%nonassoc SPACE.

%extra_argument { ParserState *state }

%include {
#include "lemon_cfg.h"
#include "log.h"
#include "lexer.h"
#include "lexer_symbols.h"
/* yy_pop_parser_stack requires assert */
//#include <assert.h>
#define assert(x) (void)(0)
#define UNUSED(x) (void)(x)
#include <stdio.h>
#include <stdlib.h>
}

%syntax_error {
    /* Clear the stack so we can shift in 'error's until a NEWLINE and hopefully recover */
    log_error("Error in parser state: %d", yypParser->yytos->stateno);
    while( yypParser->yytos > yypParser->yystack ) yy_pop_parser_stack(yypParser);
#ifndef NDEBUG
    int n;
    int i;
    int a;
    int possible;
    int encountered;
    
    log_trace("token: %s(%s)", get_token_name(yymajor), yyminor);
  
    n = sizeof(yyTokenName) / sizeof(yyTokenName[0]);
    possible = 0;
    
    for (i = 0; i < n; i++)
    {
        a = yy_find_shift_action(yypParser, (YYCODETYPE) i);
        
        if (a < YYNSTATE + YYNRULE)
        {
            if ((i > 0) && (n > 1) && (i < (n-2)))
            {
                possible++;
            }
        }
    }
    
    if (possible > 0)
    {
        encountered = 0;
        log_error("Expected: ");
    
        for (i = 0; i < n; i++)
        {
            a = yy_find_shift_action(yypParser, (YYCODETYPE)i);
            
            if (a < YYNSTATE + YYNRULE)
            {
                log_error("%s ", yyTokenName[i]);
                
                if (encountered < possible)
                {
                    log_error("or ");
                    encountered++;
                }
            }
        }
        
        log_error("\n");
    }
#else
    UNUSED(yymajor);
    UNUSED(yyminor);
#endif
    log_error("Syntax Error on line: %d!\n", state->line);
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
in  ::= in can_error_frame.
in  ::= in tfs_event.
in  ::= in sv_event.
in  ::= in watermark.
in  ::= in NEWLINE.
in  ::= error NEWLINE.
in  ::= .

/*[[[cog
  import cog
  import CogUtils as tools

  cog.out( tools.readfiles(["CanError.y", "CanMessage.y", "CanStatistics.y", "date.y", "Header.y", "Triggerblock.y", "Events.y", "LogEvents.y", "SystemVariables.y", "TestStructureEvents.y", "Watermark.y"]) )
]]]*/
/*[[[end]]]*/
