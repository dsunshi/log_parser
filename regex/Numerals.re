// Numerals
// Decimal
D = [0-9]+;
// Hexadecimal
H = [a-fA-F0-9]+;
// Extended Hex
E = [a-fA-F0-9]+ "x";

// A decimal number at least 4 digits in length
KILOD = D{4,};

KILOD { return resolve_message_duration(input); }

//[[[cog
//  import CogUtils as tools
//  import TokenManager as tm
//  from Token import Token
//  tm.add(Token("message_duration", "MESSAGE_DURATION", 10))
//  #tools.create_token("D", "DEC", 10)
//  #tools.create_token("KILOD", "KILOD", 10)
//  tools.create_token("H", "NUM", 10)
//  tools.create_token("E", "EXTENDED", 10)
//]]]
//[[[end]]]