import cog
import csv
import os.path
import operator

from Token import Token
import TokenManager as tm

include_dirs = [".", "regex", "grammar"]

def longest_name(tokens):
    length = -1
    for token in tokens:
        if len(token.plain_text) > length:
            length = len(token.plain_text)
    return length

def readfile(filename):
    text = ""
    for include_dir in include_dirs:
        try:
            file = open(os.path.join(include_dir, filename), "r")
        except IOError:
            pass
    text = file.read()
    file.close()
    return text

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
    tokens = tm.read_tokens()
    
    for token in tokens:
        cog.outl( token.c_define() )
    cog.outl( "#define NUM_TOKENS %d" % len(tokens) )

def create_table():
    tokens = tm.read_tokens()
    max_len = longest_name(tokens) + 1
    
    for index, token in enumerate(tokens):
        width = max_len - len(token.plain_text)
        if index != len(tokens) - 1:
            cog.outl( token.table_entry(width, False) )
        else:
            cog.outl( token.table_entry(width, True) )

def create_value_switch():
    tokens = tm.read_tokens()
    
    for token in tokens:
        if token.size == 0:
            cog.outl( "case %s:" % token.macro_name )
    cog.outl("\treturn BLANK;")
    cog.outl("\tbreak;")
    for token in tokens:
        if token.size > 0:
            cog.outl( "case %s:" % token.macro_name )
            cog.outl( "\tassert(length <= %d);" % token.size )
            cog.outl( "\treturn create_str(input, length);\n\tbreak;" )