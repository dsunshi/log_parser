
def readfile(filename):
    file = open(filename, "r")
    print( file.read() )
    file.close()