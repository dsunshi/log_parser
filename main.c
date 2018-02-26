#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "log.h"
#include "logilizer.h"
#include "argparse.h"
#include "lexer.h"
#include "lemon.h"
#include "lemon_cfg.h"
#include "lexer_symbols.h"

static const char * const usage[] =
{
    "test_argparse [options] [[--] args]",
    "test_argparse [options]",
    NULL,
};

char * infile  = NULL;
char * outfile = NULL;

struct argparse_option options[] =
{
    OPT_HELP(),
    OPT_GROUP("Basic options"),
    OPT_STRING('i', "input",  &infile,  "Input log file"),
    OPT_STRING('o', "output", &outfile, "Output file"),
    OPT_END(),
};

int main(int argc, char **argv)
{

    struct argparse argparse;
    logilizer_t * log;
    
    argparse_init(&argparse, options, usage, 0);
    argparse_describe(&argparse, "\nA brief description of what the program does and how it works.",
        "\nAdditional description of the program after the description of the arguments.");
    argc = argparse_parse(&argparse, argc, argv);
    
    log_set_fp(fopen("log.txt", "w"));
    log_set_quiet(1);
    
    if (outfile != NULL)
    {
        log = logilizer_new(infile, outfile);
    }
    else
    {
        log = logilizer_new(infile, "");
    }
    
    logilizer_resolve(log);
    
    logilizer_destroy(log);
    
    return 0;
}