
/* Header */
/* Base
 * Description: indicates the number system in which values are logged. It can be in hexadecimal or decimal notation.
 * Definition:  base <hex|dec> timestamps <absolute|relative>
 *
 * Timestamps
 * Description: timestamps indicates whether the timestamps are written absolute to the start of the measurementor 
 * relative to the preceding event.
 * Definition:  base <hex|dec> timestamps <absolute|relative>
 *
 * Internal events logged
 * Description: Indicates whether internal events were logged or not.
 * Definition:  <""|no> internal events logged
 */

base ::= BASE SPACE HEXADECIMAL. 
{
    printf("base hex ");
}

base ::= BASE SPACE DECIMAL. 
{
    printf("base dec ");
}

timestamps ::= TIMESTAMPS SPACE ABSOLUTE.
{
    printf("timestamps absolute\n");
}

timestamps ::= TIMESTAMPS SPACE RELATIVE.
{
    printf("timestamps relative\n");
}

logging ::= NO SPACE INTERNAL SPACE EVENTS SPACE LOGGED.
{
    printf("no internal events logged\n");
}

logging ::= INTERNAL SPACE EVENTS SPACE LOGGED.
{
    printf("internal events logged\n");
}

version ::= COMMENT SPACE VERSION SPACE DEC(major) DOT DEC(minor) DOT DEC(patch).
{
    printf("// version %s.%s.%s\n", major, minor, patch);
}