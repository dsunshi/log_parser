/* Events */
start_of_measurement ::= time(T) SPACE START SPACE OF SPACE MEASUREMENT.
{
    fprintf(state->output, "%s Start of measurement\n", T);
}

start_of_measurement ::= time(T) SPACE START SPACE DER SPACE MESSUNG.
{
    fprintf(state->output, "%s Start der Messung\n", T);
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