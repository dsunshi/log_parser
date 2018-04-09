/* Channel
 * Description: Number of the CAN channel.
 * Definition:  CAN | CAN FD 1 ... 255
 */
channel(C) ::= CAN SPACE NUM(id).
{
    C = (char *) malloc( sizeof(char) * 8);
    snprintf(C, 8, "CAN %s", id);
}

channel(C) ::= CAN_FD SPACE NUM(id).
{
    C = (char *) malloc( sizeof(char) * 11);
    snprintf(C, 11, "CANFD %s", id);
}

channel(C) ::= CANFD SPACE NUM(id).
{
    C = (char *) malloc( sizeof(char) * 11);
    snprintf(C, 11, "CANFD %s", id);
}

channel(C) ::= NUM(id).
{
    C = (char *) malloc( sizeof(char) * 4);
    snprintf(C, 4, "%s", id);
}

channel(C) ::= IDENTIFIER(name).
{
    C = (char *) malloc( sizeof(char) * 256);
    snprintf(C, 256, "%s", name);
}