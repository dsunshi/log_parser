/* CAN Error Event
 * Description: An event that provides CAN error information.
 * Definition:  <Time> CAN <Channel> Status:<Error>
 *              <Time> CAN <Channel> Status:<Error> - TxErr: <TxCount> RxErr: <RxCount>
 * <Error>: chip status warning level
 *          rx queue overrun
 *          chip status error active
 */

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

can_error_event ::= time(T) SPACE channel(C) SPACE STATUS COLON error_status(E).
{
    fprintf(state->output, "%s %s Status:%s\n", T, C, E);
}

can_error_event ::= time(T) SPACE channel(C) SPACE STATUS COLON error_status(E) SPACE HYPHEN SPACE TXERR COLON SPACE NUM(txcount) SPACE RXERR COLON SPACE NUM(rxcount).
{
    fprintf(state->output, "%s %s Status:%s - TxErr: %s RxErr: %s\n", T, C, E, txcount, rxcount);
}

can_error_frame ::= time(T) SPACE channel(C) SPACE ERRORFRAME.
{
    fprintf(state->output, "%s %s ErrorFrame\n", T, C);
}