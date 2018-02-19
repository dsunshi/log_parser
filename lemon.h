#ifndef LEMON_H_
#define LEMON_H_

/* for YYSTYPE */
#include "lemon_cfg.h"

/* for tok_t */
#include "lexer.h"

/* for size_t  */
#include "stddef.h"

#ifdef __cplusplus
extern "C" {
#endif
/******************************** WARNING *************************************/
/* These function prototypes depend on the lempar.c template file. If any
 * changes have been made to the template file than these will need to be
 * updated as well.
 *
 * NOTE 1: The directive %name affects these function prototypes.
 
    %name Abcde
    
    Putting this directive in the grammar file will cause Lemon to generate functions named:

    AbcdeAlloc(),
    AbcdeFree(),
    AbcdeTrace(), and
    Abcde().
 * NOTE 2: the directive %extra_argument affects the Parse function.
 
    %extra_argument { MyStruct *pAbc }
    
    Putting this directive in the grammar file will cause Lemon to generate a variable named ``pAbc'' that is the value
    of the 4th parameter in the most recent call to Parse().
 * 
*******************************************************************************/
void *ParseAlloc(
  void *(*mallocProc)(size_t)   /* The function used to claim memory */
);

void Parse(
  void *yyp,                    /* The parser */
  tok_t yymajor,                /* The token type */
  YYSTYPE yyminor,              /* The value for the token */
  /* , ParseARG_PDECL  */       /* Optional %extra_argument parameter */
  ParserState *state
);

void ParseFree(
  void *p,                      /* The parser to be deleted */
  void (*freeProc)(void*)       /* Function used to reclaim memory */
);

void ParseTrace(
  FILE *TraceFILE,              /* File to which trace output should be written */
  char *zTracePrompt            /* A prefix string written at the beginning of every line of trace output */
);

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif