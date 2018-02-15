#ifndef LEMON_H_
#define LEMON_H_

/* for YYSTYPE */
#include "lemon_cfg.h"

/* for size_t  */
#include "stddef.h"

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
  int yymajor,                  /* The major token code number */
  YYSTYPE yyminor,              /* The value for the token */
  /* , ParseARG_PDECL  */       /* Optional %extra_argument parameter */
  ParserState *state
);

void ParseFree(
  void *p,                     /* The parser to be deleted */
  void (*freeProc)(void*)      /* Function used to reclaim memory */
);

#endif