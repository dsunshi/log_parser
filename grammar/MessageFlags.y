message_flags(flags) ::= TE.
{
    flags = (char *) malloc( sizeof(char) * 3);
    snprintf(flags, 3, "TE");
}

message_flags(flags) ::= WU.
{
    flags = (char *) malloc( sizeof(char) * 3);
    snprintf(flags, 3, "WU");
}

message_flags(flags) ::= XX.
{
    flags = (char *) malloc( sizeof(char) * 3);
    snprintf(flags, 3, "XX");
}