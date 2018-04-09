/* Time
 * Description: absolute or relative time in seconds. (usually 4 decimal places - up to 9 possible)
 */

time(Time) ::= NUM(seconds) DOT NUM(microseconds).
{
    Time = (char *) malloc( sizeof(char) * 15);
    snprintf(Time, 15, "%s.%s", seconds, microseconds);
}

time(Time) ::= HYPHEN NUM(seconds) DOT NUM(microseconds).
{
    Time = (char *) malloc( sizeof(char) * 15);
    snprintf(Time, 15, "-%s.%s", seconds, microseconds);
}