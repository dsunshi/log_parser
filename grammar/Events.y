
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
log_trigger_event ::= time(T) SPACE LOG SPACE TRIGGER SPACE EVENT.
{
    fprintf(state->output, "%s log trigger event\n", T);
}

log_trigger_event ::= time(T) SPACE LOG SPACE TRIGGER SPACE EVENT SPACE LOG_COMMENT.
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

/*[[[cog
import cog
import CogUtils as tools

for bytes_per_msg in range(0, 8):
    cog.out( "can_message_data(message_data) ::= time(T) SPACE channel(C) SPACE id(message_id) SPACE dir(D) SPACE D SPACE NUM(dlc)" )
    bytes = ""
    for byte_in_msg in range(0, bytes_per_msg + 1):
        cog.out(" SPACE NUM(byte_%s)" % byte_in_msg)
        bytes += ", byte_%s" % byte_in_msg
    cog.outl(".\n{")
    cog.outl("\tsize_t length = strlen(T) + strlen(C) + strlen(message_id) + strlen(D) + strlen(dlc) + 10 + (2 * %s);" % (bytes_per_msg + 1))
    cog.outl("\tmessage_data = (char *) malloc( sizeof(char) * length );")
    cog.outl("\tsnprintf(message_data, length, \"%%s %%s %%s %%s d %%s %s\", T, C, message_id, D, dlc%s);" % ("%s " * (bytes_per_msg + 1), bytes) )
    cog.outl("}\n")
]]]*/
/*[[[end]]]*/

can_message_info(message_info) ::= LENGTH SPACE EQUALS SPACE NUM(message_duration) SPACE BITCOUNT SPACE EQUALS SPACE NUM(message_length) SPACE ID SPACE EQUALS SPACE NUM(id_num).
{
    message_info = (char *) malloc( sizeof(char) * 100 );
    snprintf(message_info, 100, "Length = %s BitCount = %s ID = %s", message_duration, message_length, id_num);
}

can_message_info(message_info) ::= LENGTH SPACE EQUALS SPACE NUM(message_duration) SPACE BITCOUNT SPACE EQUALS SPACE NUM(message_length).
{
    message_info = (char *) malloc( sizeof(char) * 100 );
    snprintf(message_info, 100, "Length = %s BitCount = %s", message_duration, message_length);
}

can_message ::= can_message_data(message_data).
{
    fprintf(state->output, "%s\n", message_data);
}

can_message ::= can_message_data(message_data) SPACE can_message_info(message_info).
{
    fprintf(state->output, "%s %s\n", message_data, message_info);
}

can_error_frame ::= time(T) SPACE channel(C) SPACE ERRORFRAME.
{
    fprintf(state->output, "%s %s ErrorFrame\n", T, C);
}

test_verdict(V) ::= FAILED.
{
    V = (char *) malloc( sizeof(char) * 10);
    snprintf(V, 10, "Failed");
}

test_verdict(V) ::= PASSED.
{
    V = (char *) malloc( sizeof(char) * 10);
    snprintf(V, 10, "Passed");
}

test_module(M) ::= test_verdict(V) COLON SPACE TEST SPACE MODULE.
{
    M = (char *) malloc( sizeof(char) * 30);
    snprintf(M, 30, "%s: Test module", V);
}

test_module(M) ::= TEST SPACE MODULE.
{
    M = (char *) malloc( sizeof(char) * 30);
    snprintf(M, 30, "Test module");
}

test_status(S) ::= STARTED DOT.
{
    S = (char *) malloc( sizeof(char) * 20);
    snprintf(S, 20, "started.");
}

test_status(S) ::= FINISHED DOT.
{
    S = (char *) malloc( sizeof(char) * 20);
    snprintf(S, 20, "finished.");
}

tfs_event_text(T) ::= TEST SPACE CONFIGURATION SPACE SQSTR(config) COMMA SPACE TEST SPACE UNIT SPACE SQSTR(unit) COLON SPACE TEST SPACE CASE SPACE SQSTR(case) SPACE test_status(status).
{
    T = (char *) malloc( sizeof(char) * 256);
    snprintf(T, 256, "Test configuration %s, Test unit %s: Test case %s %s.", config, unit, case, status);
}

tfs_event_text(T) ::= test_verdict(verdict) TEST SPACE CONFIGURATION SPACE SQSTR(config) COMMA SPACE TEST SPACE UNIT SPACE SQSTR(unit) COLON SPACE TEST SPACE CASE SPACE SQSTR(case) SPACE test_status(status).
{
    T = (char *) malloc( sizeof(char) * 256);
    snprintf(T, 256, "%s: Test configuration %s, Test unit %s: Test case %s %s.", verdict, config, unit, case, status);
}

// You cannot have a name in parens that matches a token!!
tfs_event_text(T) ::= test_module(M) SPACE SQSTR(module) COLON SPACE TEST SPACE CASE SPACE SQSTR(test_case) SPACE test_status(S).
{
    T = (char *) malloc( sizeof(char) * 256);
    snprintf(T, 256, "%s %s: Test case %s %s", M, module, test_case, S);
}

tfs_event_text(T) ::= test_module(M) SPACE SQSTR(module) SPACE test_status(S).
{
    T = (char *) malloc( sizeof(char) * 256);
    snprintf(T, 256, "%s %s %s", M, module, S);
}

tfs_event_text(T) ::= test_module(M) SPACE SQSTR(module).
{
    T = (char *) malloc( sizeof(char) * 256);
    snprintf(T, 256, "%s %s", M, module);
}

tfs_event ::= time(S) SPACE TFS COLON SPACE LBRACKET NUM(execID) COMMA NUM(elementID) RBRACKET SPACE tfs_event_text(T).
{
    fprintf(state->output, "%s TFS: [%s,%s] %s", S, execID, elementID, T);  
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

sv_event ::= time(S) SPACE SV COLON SPACE frame_data(info) SPACE COLON COLON IDENTIFIER(variable) SPACE EQUALS SPACE frame_data(values).
{
    fprintf(state->output, "%s SV: %s ::%s = %s", S, info, variable, values); 
}
