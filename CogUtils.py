
def readfile(filename):
    text = ""
    file = open(filename, "r")
    text = file.read()
    file.close()
    return text