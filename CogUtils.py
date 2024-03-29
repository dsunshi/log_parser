from __future__ import print_function

import cog
import csv
import os.path
import operator
import sys

from Token import Token
import TokenManager as tm

include_dirs = [".", "regex", "grammar"]

def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)

def longest_name(tokens):
    length = -1
    for token in tokens:
        if len(token.plain_text) > length:
            length = len(token.plain_text)
    return length

def longest_macro(tokens):
    length = -1
    for token in tokens:
        if len(token.macro_name) > length:
            length = len(token.macro_name)
    return length

def readfile(filename):
    text = ""
    found = False
    for include_dir in include_dirs:
        try:
            file = open(os.path.join(include_dir, filename), "r")
            found = True
        except IOError:
            pass
    if found:
        text += "//" + ("-" * 78) + "\n"
        text += "// Content included from %s:\n" % filename
        text += "//" + ("-" * 78) + "\n"
        text += file.read()
        file.close()
        return text
    else:
        eprint("*** Error: Failed to read in file: " + filename)
        sys.exit(-1)

def readfiles(filenames):
    text = ""
    for filename in filenames:
        text += readfile(filename)
        text += "\n\n"
    return text

def simple_token(name):
    create_token(name, name.upper())
    
def simple_action(name, action):
    create_token(name, name.upper(), 0, action)

def create_token(name, symbol, size=0, action=""):
    token = Token(name, symbol, size)
    cog.outl( token.re2c(action) )
    tm.add(token)

def create_defines():
    tm.update_values()
    tokens = sorted(tm.read_tokens())
    max_len = longest_macro(tokens) + 1
    
    for token in tokens:
        width = max_len - len(token.macro_name)
        cog.outl( token.c_define(width) )
    cog.outl( "#define NUM_TOKENS%s%d" % (" " * (max_len - len("NUM_TOKENS")), len(tokens)) )

def create_table():
    tokens = tm.read_tokens()
    max_len = longest_name(tokens) + 1
    
    for index, token in enumerate(tokens):
        width = max_len - len(token.plain_text)
        if index != len(tokens) - 1:
            cog.outl( token.table_entry(width, False) )
        else:
            cog.outl( token.table_entry(width, True) )

def create_value_switch(num=False):
    tokens = tm.read_tokens()
    
    for token in tokens:
        if num == False:
            if (token.size > 0) and (token.macro_name != "TOKEN_NUM"):
                cog.outl( "case %s:" % token.macro_name )
                cog.outl( "\tassert(length <= %d);" % token.size )
                cog.outl( "\treturn create_str(input->token, length);" )
        else:
            if token.macro_name == "TOKEN_NUM":
                cog.outl( "\tassert(length <= %d);" % token.size )
                cog.outl( "\treturn create_str(input->token, length);" )
        