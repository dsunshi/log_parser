
/* Events */
/* Time
 * Description: absolute or relative time in seconds. (usually 4 decimal places - up to 9 possible)
 */

time(T) ::= DEC(seconds) DOT DEC(microseconds).
{
    T = (char *) malloc( sizeof(char) * 15);
    snprintf(T, 15, "%s.%s", seconds, microseconds);
}

time(T) ::= HYPHEN DEC(seconds) DOT DEC(microseconds).
{
    T = (char *) malloc( sizeof(char) * 15);
    snprintf(T, 15, "-%s.%s", seconds, microseconds);
}

/* Channel
 * Description: Number of the CAN channel.
 * Definition:  CAN | CAN FD 1 ... 255
 */
channel(C) ::= CAN SPACE DEC(id).
{
    C = (char *) malloc( sizeof(char) * 8);
    snprintf(C, 8, "CAN %s", id);
    log_trace("Channel: %s\n", C);
}

channel(C) ::= CAN_FD SPACE DEC(id).
{
    C = (char *) malloc( sizeof(char) * 11);
    snprintf(C, 11, "CANFD %s", id);
    log_trace("Channel: %s\n", C);
}

channel(C) ::= DEC(id).
{
    C = (char *) malloc( sizeof(char) * 4);
    snprintf(C, 4, "%s", id);
    log_trace("Channel: %s\n", C);
}

channel(C) ::= channel_name(name).
{
    C = (char *) malloc( sizeof(char) * 256);
    snprintf(C, 256, "%s", name);
    log_trace("Channel: %s\n", C);
}

channel_name(name) ::= IDENTIFIER(existing).
{
    name = (char *) malloc( sizeof(char) * 256);
    log_trace("existing: %s\n", existing);
}

channel_name(name) ::= channel_name(text) SPACE IDENTIFIER(existing).
{
    name = (char *) malloc( sizeof(char) * 256);
    log_trace("existing: %s\ntext: %s\n", existing, text);
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
can_error_event ::= time(T) SPACE channel(C) STATUS COLON error_status(E).
{
    fprintf(state->output, "%s %s Status:%s\n", T, C, E);
}

can_error_event ::= time(T) SPACE channel(C) STATUS COLON error_status(E) SPACE HYPHEN SPACE TXERR COLON SPACE DEC(txcount) SPACE RXERR COLON SPACE DEC(rxcount).
{
    fprintf(state->output, "%s %s Status:%s - TxErr: %s RxErr: %s\n", T, C, E, txcount, rxcount);
}

/* The prefered name would be just "error", but it is used by lemon, so... */
error_status(E) ::= CHIP STATUS SPACE WARNING SPACE LEVEL.
{
    E = (char *) malloc( sizeof(char) * 30 );
    snprintf(E, 30, "chip status warning level");
}

error_status(E) ::= RX SPACE QUEUE SPACE OVERRUN.
{
    E = (char *) malloc( sizeof(char) * 20 );
    snprintf(E, 20, "rx queue overrun");
}

error_status(E) ::= CHIP STATUS SPACE ERROR SPACE ACTIVE.
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
can_statistic_event ::= time(T) SPACE channel(C) STATISTIC COLON SPACE D SPACE DEC(num_d) SPACE R SPACE DEC(num_r) SPACE XD SPACE DEC(num_xd) SPACE XR SPACE DEC(num_xr) SPACE E SPACE DEC(num_e) SPACE O SPACE DEC(num_o) SPACE B SPACE DEC(p0) DOT DEC(p1) PERCENT.
{
    fprintf(state->output, "%s %s Statistic: D %s R %s XD %s XR %s E %s O %s B %s.%s\%\n", T, C, num_d, num_r, num_xd, num_xr, num_e, num_o, p0, p1);
} 