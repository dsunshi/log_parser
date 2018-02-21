
/* Events */
/* Time
 * Description: absolute or relative time in seconds. (usually 4 decimal places)
 */

time(T) ::= DEC(seconds) DOT DEC(microseconds).
{
    T = (char *) malloc( sizeof(char) * 15);
    snprintf(T, 15, "%s.%s", seconds, microseconds);
}

/* Channel
 * Description: Number of the CAN channel.
 * Definition:  CAN | CAN FD 1 ... 255
 */
channel(C) ::= CAN SPACE DEC(id).
{
    C = (char *) malloc( sizeof(char) * 8);
    snprintf(C, 8, "CAN %s", id);
}

channel(C) ::= CAN_FD SPACE DEC(id).
{
    C = (char *) malloc( sizeof(char) * 11);
    snprintf(C, 11, "CAN FD %s", id);
}

start_of_measurement ::= time(T) SPACE START SPACE OF SPACE MEASUREMENT.
{
    printf("%s Start of measurement\n", T);
}

start_of_measurement ::= time(T) SPACE START SPACE DER SPACE MESSUNG.
{
    printf("%s Start der Messung\n", T);
}

/* CAN Error Event
 * Description: An event that provides CAN error information.
 * Definition:  <Time> CAN <Channel> Status:<Error>
 *              <Time> CAN <Channel> Status:<Error> - TxErr: <TxCount> RxErr: <RxCount>
 * <Error>: chip status warning level
 *          rx queue overrun
 *          chip status error active
 */
can_error_event ::= time(T) SPACE channel(C) SPACE STATUS COLON error_status(E).
{
    printf("%s %s Status:%s\n", T, C, E);
}

can_error_event ::= time(T) SPACE channel(C) SPACE STATUS COLON error_status(E) SPACE HYPHEN SPACE TXERR COLON SPACE DEC(txcount) SPACE RXERR COLON SPACE DEC(rxcount).
{
    printf("%s %s Status:%s - TxErr: %s RxErr: %s\n", T, C, E, txcount, rxcount);
}

/* The prefered name would be just "error", but it is used by lemon, so... */
error_status(E) ::= CHIP SPACE STATUS SPACE WARNING SPACE LEVEL.
{
    E = (char *) malloc( sizeof(char) * 30 );
    snprintf(E, 30, "chip status warning level");
}

error_status(E) ::= RX SPACE QUEUE SPACE OVERRUN.
{
    E = (char *) malloc( sizeof(char) * 20 );
    snprintf(E, 20, "rx queue overrun");
}

error_status(E) ::= CHIP SPACE STATUS SPACE ERROR SPACE ACTIVE.
{
    E = (char *) malloc( sizeof(char) * 30 );
    snprintf(E, 30, "chip status error active");
}