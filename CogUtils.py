import cog
import csv
import os.path

TOKEN_PREFIX = "TOKEN_"
TOKEN_FILE   = "tokens.csv"

CSV_FIELD_NAMES = ["plain_text", "define"]

def write_token_info(token_info):
    if os.path.isfile(TOKEN_FILE):
        token_file = open(TOKEN_FILE, "a")
        writer = csv.DictWriter(token_file, fieldnames=CSV_FIELD_NAMES)
    else:
        token_file = open(TOKEN_FILE, "w")
        writer = csv.DictWriter(token_file, fieldnames=CSV_FIELD_NAMES)
        writer.writeheader()
    writer.writerow(token_info)
    token_file.close()

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

def create_token(name, symbol, prefix=TOKEN_PREFIX):
    token = "%s%s" % (prefix, symbol)
    cog.outl( "%s\t\t\t\t\t{ return %s; }" % (name, token) )
    
    write_token_info({'plain_text' : name, 'define' : token})

def create_defines():
    cog.outl( "#define\tTOKEN_UNKOWN\t1")
    with open(TOKEN_FILE, "r") as token_file:
        reader = csv.DictReader(token_file)
        index  = 2
        for row in reader:
            cog.outl( "#define\t%s\t%s" % (row['define'], index))
            index = index + 1

def create_table():
    cog.outl( "\"?\",")
    with open(TOKEN_FILE, "r") as token_file:
        reader = csv.DictReader(token_file)
        for row in reader:
            cog.outl( "\"%s\",\n" % row['plain_text'])
            