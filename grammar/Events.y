/* Events */
/* Time
 * Description: absolute or relative time in seconds. (usually 4 decimal places - up to 9 possible)
 */

time(T) ::= NUM(seconds) DOT NUM(microseconds).
{
    T = (char *) malloc( sizeof(char) * 15);
    snprintf(T, 15, "%s.%s", seconds, microseconds);
}

time(T) ::= HYPHEN NUM(seconds) DOT NUM(microseconds).
{
    T = (char *) malloc( sizeof(char) * 15);
    snprintf(T, 15, "-%s.%s", seconds, microseconds);
}

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

start_of_measurement ::= time(T) SPACE START SPACE OF SPACE MEASUREMENT.
{
    fprintf(state->output, "%s Start of measurement\n", T);
}

start_of_measurement ::= time(T) SPACE START SPACE DER SPACE MESSUNG.
{
    fprintf(state->output, "%s Start der Messung\n", T);
}

/* CAN Events on a Classic CAN bus */
dir(D) ::= RX.
{
    D = (char *) malloc( sizeof(char) * 3 );
    snprintf(D, 3, "Rx");
}

dir(D) ::= TX.
{
    D = (char *) malloc( sizeof(char) * 3 );
    snprintf(D, 3, "Tx");
}

dir(D) ::= TXRQ.
{
    D = (char *) malloc( sizeof(char) * 5 );
    snprintf(D, 5, "TxRq");
}

id(ID) ::= NUM(msg_id).
{
    ID = (char *) malloc( sizeof(char) * 10 );
    snprintf(ID, 10, "%s", msg_id);
}

id(ID) ::= EXTENDED(msg_id).
{
    ID = (char *) malloc( sizeof(char) * 10 );
    snprintf(ID, 10, "%s", msg_id);
}

frame_data(D) ::= frame_data(original) SPACE NUM(value).
{
    size_t length = strlen(original) + 10;
    D = (char *) malloc( sizeof(char) * length);
    snprintf(D, length, "%s %s", original, value);
}

frame_data(D) ::= NUM(value).
{
    D = (char *) malloc( sizeof(char) * 10);
    snprintf(D, 10, "%s", value);
}
