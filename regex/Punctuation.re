// Punctuation
equals      = "=";
rbracket    = "]";
lbracket    = "[";
colon       = ":";
dot         = ".";
comma       = ",";
rparen      = ")";
lparen      = "(";
exclamation = "!";
percent     = "%";
hyphen      = "-";
comment     = "//";

// Single Quoted String
sqstr = "'"  [^']* "'";

// Double Quoted String
dqstr = "\""  [^"]* "\"";

//[[[cog
//  import CogUtils as tools
//  tools.simple_token("colon")
//  tools.simple_token("dot")
//  tools.simple_token("comment")
//  tools.simple_token("hyphen")
//  tools.simple_token("percent")
//  tools.simple_token("lparen")
//  tools.simple_token("rparen")
//  tools.simple_token("equals")
//  tools.create_token("sqstr", "SQSTR", 256)
//  tools.simple_token("lbracket")
//  tools.simple_token("rbracket")
//  tools.simple_token("comma")
//]]]
//[[[end]]]