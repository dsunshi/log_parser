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