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