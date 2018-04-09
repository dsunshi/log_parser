
#ifndef __LEXER_UTILS_H_
#define __LEXER_UTILS_H_

#ifdef __cplusplus
extern "C" {
#endif

yyinput_t * lexer_new(FILE * file, const size_t size, const size_t maxfill);
void lexer_destroy(yyinput_t * lexer);

bool fill(yyinput_t * input, const size_t need);

tok_t   lex(yyinput_t * input);
YYSTYPE get_token_value(yyinput_t * input, tok_t token);
tok_t   exit_success(yyinput_t * input);

void free_token(YYSTYPE token);

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif