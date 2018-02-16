%token_prefix TOKEN_

%token_type    { YYSTYPE }
%type WEEKDAY  { YYSTYPE }
%type MONTH    { YYSTYPE }
%type NUM      { YYSTYPE }
%type fulltime {YYSTYPE }

%nonassoc WEEKDAY.
%nonassoc MONTH.
%nonassoc NUM.
%nonassoc END.
%nonassoc NEWLINE.
%nonassoc DATE.
%nonassoc SPACE.
%nonassoc DEC.
%nonassoc COLON.
%nonassoc DOT.
%nonassoc AM.
%nonassoc PM.

%extra_argument { ParserState *state }

%include {
#include "stdio.h"
#include "lemon_cfg.h"
/* yy_pop_parser_stack requires assert */
#include "assert.h"
#include "stdlib.h"
}

%syntax_error {
    int n;
    int i;
    
    fprintf(stderr, "Syntax Error!\n");
    
    n = sizeof(yyTokenName) / sizeof(yyTokenName[0]);
    
    fprintf(stderr, "Expected: ");
    
    for (i = 0; i < n; i++)
    {
            int a = yy_find_shift_action(yypParser, (YYCODETYPE)i);
            
            if (a < YYNSTATE + YYNRULE)
            {
                fprintf(stderr, "%s ", yyTokenName[i]);
                if ((i > 0) && (n > 1) && (i < (n-2)))
                {
                        fprintf(stderr, "or ");
                }
            }
            
    }
    fprintf(stderr, "\n");
    exit(-1);
}

%parse_failure {
    fprintf(stderr, "Giving up.  Parser is hopelessly lost...\n");
    //exit(-1);
}

%stack_overflow {
    fprintf(stderr, "Giving up.  Parser stack overflow\n");
}

%start_symbol log

log ::= in END.
in ::= in date.
in ::= in NEWLINE.
in ::= .

/*[[[cog
  import cog
  import CogUtils as tools

  cog.out( tools.readfiles(["date.y"]) )
]]]*/
/*[[[end]]]*/
