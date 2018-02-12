
#ifndef __TESTS_H_
#define __TESTS_H_

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include "../lexer.h"
#include "../lexer_symbols.h"

#ifdef __cplusplus
extern "C" {
#endif

MunitResult test_date_lex(const MunitParameter params[], void* user_data);

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif