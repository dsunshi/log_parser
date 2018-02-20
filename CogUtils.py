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

def create_token(name, symbol):
    token = Token(name, symbol)
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