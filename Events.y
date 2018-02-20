
/* Events */
/* Time
 * Description: absolute or relative time in seconds. (usually 4 decimal places)
 */

time(T) ::= DEC(seconds) DOT DEC(microseconds).
{
    T = (char *) malloc( sizeof(char) * 15);
    snprintf(T, 15, "%s.%s", seconds, microseconds);
}

start_of_measurement ::= time(T) SPACE START SPACE OF SPACE MEASUREMENT.
{
    printf("%s Start of measurement\n", T);
}

start_of_measurement ::= time(T) SPACE START SPACE DER SPACE MESSUNG.
{
    printf("%s Start der Messung\n", T);
}