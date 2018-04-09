// Numerals
// Decimal
D = [0-9]+;
// Hexadecimal
H = [a-fA-F0-9]+;
// Extended Hex
E = [a-fA-F0-9]+ "x";

// A decimal number at least 4 digits in length
KILOD = D{4,};

//[[[cog
//  import CogUtils as tools
//  #tools.create_token("D", "DEC", 10)
//  #tools.create_token("KILOD", "KILOD", 10)
//  tools.create_token("H", "NUM", 10)
//  tools.create_token("E", "EXTENDED", 10)
//]]]
//[[[end]]]