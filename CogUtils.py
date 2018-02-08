
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