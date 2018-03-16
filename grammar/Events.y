
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
    log_trace("Channel: %s\n", C);
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
    fprintf(state->output, "%s %s Status:%s\n", T, C, E);
}

can_error_event ::= time(T) SPACE channel(C) SPACE STATUS COLON error_status(E) SPACE HYPHEN SPACE TXERR COLON SPACE NUM(txcount) SPACE RXERR COLON SPACE NUM(rxcount).
{
    fprintf(state->output, "%s %s Status:%s - TxErr: %s RxErr: %s\n", T, C, E, txcount, rxcount);
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

/* CAN Bus Statistics Event
 * Description: CAN Statistic event, which contains statistic information about the CAN channels.
 *  - "D"  stands for CAN Data Frames
 *  - "R"  stands for CAN Remote Frames
 *  - "XD" stands for CAN Extended Data Frames
 *  - "XR" stands for CAN Extended Remote Frames
 *  - "E"  stands for Error Frames
 *  - "O"  stands for Overload Frames
 *  - "B"  stands for Busload
 * Definition: <Time> <Channel> Statistic: D <StatNumber> R <StatNumber> XD <StatNumber> XR <StatNumber> E <StatNumber> O <StatNumber> B <StatPercent>%
 */
can_statistic_event ::= time(T) SPACE channel(C) SPACE STATISTIC COLON SPACE D SPACE NUM(num_d) SPACE R SPACE NUM(num_r) SPACE XD SPACE NUM(num_xd) SPACE XR SPACE NUM(num_xr) SPACE E SPACE NUM(num_e) SPACE O SPACE NUM(num_o) SPACE B SPACE NUM(p0) DOT NUM(p1) PERCENT.
{
    fprintf(state->output, "%s %s Statistic: D %s R %s XD %s XR %s E %s O %s B %s.%s\%\n", T, C, num_d, num_r, num_xd, num_xr, num_e, num_o, p0, p1);
}

/* Log and Trigger Events */
log_trigger_event ::= time(T) SPACE LOG TRIGGER EVENT.
{
    fprintf(state->output, "%s log trigger event\n", T);
}

log_direct_event ::= time(T) SPACE LOG SPACE DIRECT SPACE START SPACE LPAREN NUM(pretrigger) MS RPAREN.
{
    fprintf(state->output, "%s log direct start (%sms)\n", T, pretrigger);
}

log_direct_event ::= time(T) SPACE LOG SPACE DIRECT SPACE STOP SPACE LPAREN NUM(pretrigger) MS RPAREN.
{
    fprintf(state->output, "%s log direct stop (%sms)\n", T, pretrigger);
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

can_message_data(message_data) ::= time(T) SPACE channel(C) SPACE NUM(message_id) SPACE dir(D) SPACE D SPACE NUM(dlc) SPACE NUM(byte_0).
{
    log_trace("%s %s %s %s %s %s", T, C, message_id, D, dlc, byte_0);
    message_data = (char *) malloc( sizeof(char) * 30 );
    snprintf(message_data, 30, "");
}

can_message_data(message_data) ::= time(T) SPACE channel(C) SPACE NUM(message_id) SPACE dir(D) SPACE D SPACE NUM(dlc) SPACE NUM(byte_0) SPACE NUM(byte_1).
{
    log_trace("%s %s %s %s %s %s %s", T, C, message_id, D, dlc, byte_0, byte_1);
    message_data = (char *) malloc( sizeof(char) * 30 );
    snprintf(message_data, 30, "");
}

can_message_info(message_info) ::= LENGTH SPACE EQUALS SPACE NUM(message_duration) SPACE BITCOUNT SPACE EQUALS SPACE NUM(message_length) SPACE ID SPACE EQUALS SPACE NUM(id_num).
{
    UNUSED(message_duration);
    UNUSED(message_length);
    UNUSED(id_num);
    message_info = (char *) malloc( sizeof(char) * 30 );
    snprintf(message_info, 30, "");
}

can_message_info(message_info) ::= LENGTH SPACE EQUALS SPACE NUM(message_duration) SPACE BITCOUNT SPACE EQUALS SPACE NUM(message_length).
{
    UNUSED(message_duration);
    UNUSED(message_length);
    message_info = (char *) malloc( sizeof(char) * 30 );
    snprintf(message_info, 30, "");
}

can_message ::= can_message_data(message_data).
{
    UNUSED(message_data);
}

can_message ::= can_message_data(message_data) SPACE can_message_info(message_info).
{
    UNUSED(message_data);
    UNUSED(message_info);
}


