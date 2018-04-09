id(ID) ::= NUM(msg_id).
{
    ID = (char *) malloc( sizeof(char) * 10 );
    snprintf(ID, 10, "%s", msg_id);
}

id(ID) ::= EXTENDED(msg_id).
{
    ID = (char *) malloc( sizeof(char) * 11 );
    snprintf(ID, 11, "%s", msg_id);
}