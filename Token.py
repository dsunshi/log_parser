# desired column minus the number of tabs and spaces per tab
COL_WIDTH = 33 - (3 * 4)

class Token:
    def __init__(self, text="", name="", size=0, prefix="TOKEN_", value=-1):
        """ Create a new token with the printable value text, macro name name, and macro value value """
        # plain_text is the string that appears in re2c as well as the printable name during symbol lookup
        self.plain_text = text
        # macro_name is the name of the c #define
        self.macro_name = prefix + name
        # id is the value of the macro_name
        self.id         = value
        # size is the maximum width in characters that this tokens value can be
        self.size       = size
    
    def c_define(self):
        """ Return a string valid for use in a c header file """
        return "#define\t%s\t%s" % (self.macro_name, self.id)
        
    def table_entry(self, last=False):
        """ Return a string valid for inclusion in a c table """
        entry = "    {\"%s\", %s}" % (self.plain_text, self.macro_name)
        if last is False:
            entry = entry + ","
        return entry
    
    def re2c(self, action=""):
        spaces = " " * (COL_WIDTH - len(self.plain_text))
        if len(action) == 0:
            return "%s%s{ return %s; }" % (self.plain_text, spaces, self.macro_name)
        else:
            return "%s%s{ %s; return %s; }" % (self.plain_text, spaces, action, self.macro_name)
    
    def __str__(self):
        return "{plain: %s, macro: %s, ID: %d}" % (self.plain_text, self.macro_name, self.id)
    
    def __eq__(self, other):
        return self.macro_name == other.macro_name
        
    def __cmp__(self, other):
        return self.macro_name == other.macro_name
    
    def __lt__(self, other):
        return self.macro_name < other.macro_name
        
    def __hash__(self):
        return hash(self.macro_name)