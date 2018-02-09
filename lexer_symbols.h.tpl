
#ifndef __LEXER_SYMBOLS_H_
#define __LEXER_SYMBOLS_H_

/*[[[cog
import CogUtils as tools

tools.create_defines()
]]]*/
/*[[[end]]]*/

#ifdef __cplusplus
extern "C" {
#endif

const char * get_token_name(const int token_id);

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif