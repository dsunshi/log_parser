
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
    fprintf(state->output, "base hex ");
}

base ::= BASE SPACE DECIMAL. 
{
    fprintf(state->output, "base dec ");
}

timestamps ::= TIMESTAMPS SPACE ABSOLUTE.
{
    fprintf(state->output, "timestamps absolute\n");
}

timestamps ::= TIMESTAMPS SPACE RELATIVE.
{
    fprintf(state->output, "timestamps relative\n");
}

logging ::= NO SPACE INTERNAL SPACE EVENTS SPACE LOGGED.
{
    fprintf(state->output, "no internal events logged\n");
}

logging ::= INTERNAL SPACE EVENTS SPACE LOGGED.
{
    fprintf(state->output, "internal events logged\n");
}

version ::= COMMENT SPACE VERSION SPACE NUM(major) DOT NUM(minor) DOT NUM(patch).
{
    fprintf(state->output, "// version %s.%s.%s\n", major, minor, patch);
}