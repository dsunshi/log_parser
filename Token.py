class Token:   
    def __init__(self, text="", name="", prefix="TOKEN_", value=-1):
        """ Create a new token with the printable value text, macro name name, and macro value value """
        # plain_text is the string that appears in re2c as well as the printable name during symbol lookup
        self.plain_text = text
        # macro_name is the name of the c #define
        self.macro_name = prefix + name
        # id is the value of the macro_name
        self.id         = value
    
    def c_define(self):
        """ Return a string valid for use in a c header file """
        return "#define\t%s\t%s" % (self.macro_name, self.id)
        
    def table_entry(self, last=False):
        """ Return a string valid for inclusion in a c table """
        entry = "    {\"%s\", %s}" % (self.plain_text, self.macro_name)
        if last is False:
            entry = entry + ","
        return entry
    
    def re2c(self):
        return "%s\t\t\t\t\t{ return %s; }" % (self.plain_text, self.macro_name)
    
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