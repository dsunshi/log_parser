import cog
import csv
import os.path
import operator

from Token import Token
import TokenManager as tm

def readfile(filename):
    text = ""
    file = open(filename, "r")
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

def create_token(name, symbol, size=0):
    token = Token(name, symbol, size)
    cog.outl( token.re2c() )
    tm.add(token)

def create_defines():
    tm.update_values()
    tokens = tm.read_tokens()
    
    for token in tokens:
        cog.outl( token.c_define() )
    cog.outl( "#define NUM_TOKENS %d" % len(tokens) )

def create_table():
    tokens = tm.read_tokens()
    
    for token in tokens:
        cog.outl( token.table_entry() )

def create_value_switch():
    tokens = tm.read_tokens()
    
    for token in tokens:
        if token.size == 0:
            cog.outl( "case %s:\n\treturn BLANK;\n\tbreak;" % token.macro_name )
        else:
            cog.outl( "case %s:" % token.macro_name )
            cog.outl( "\tassert(length <= %d);" % token.size )
            cog.outl( "\treturn create_str(input, length);\n\tbreak;" )