id(ID) ::= set_event_msg_std NUM(msg_id).
{
    ID = (char *) malloc( sizeof(char) * 10 );
    snprintf(ID, 10, "%s", msg_id);
}

id(ID) ::= set_event_msg_ext EXTENDED(msg_id).
{
    ID = (char *) malloc( sizeof(char) * 11 );
    snprintf(ID, 11, "%s", msg_id);
}