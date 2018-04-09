
/* Date 
 * Definition: date <WeekDay> <Month> <Date> <Fulltime> <Year>
*/
date ::= set_event_general_date DATE SPACE time_and_date(TD).
{
    /* Date line */
    fprintf(state->output, "date %s\n", TD);
}

time_and_date(TD) ::= WEEKDAY(weekday) SPACE MONTH(month) SPACE NUM(day_of_month) SPACE fulltime(timestamp) NUM(year).
{
    TD = (char *) malloc( sizeof(char) * 37 );
    snprintf(TD, 37, "%s %s %s %s %s", weekday, month, day_of_month, timestamp, year);
}

/*
 * Definition:  fulltime
 * Description: HH:MM:SS(.MILLIS) (am|pm)
 */
fulltime(FT) ::= NUM(hours) COLON NUM(minutes) COLON NUM(seconds) DOT NUM(milliseconds) SPACE.
{
    /* German fulltime (no am or pm) */
    FT = (char *) malloc( sizeof(char) * 13 );
    snprintf(FT, 13, "%s:%s:%s.%s", hours, minutes, seconds, milliseconds);
}

fulltime(FT) ::= NUM(hours) COLON NUM(minutes) COLON NUM(seconds) SPACE.
{
    /* German fulltime (no am or pm) */
    FT = (char *) malloc( sizeof(char) * 13 );
    snprintf(FT, 13, "%s:%s:%s", hours, minutes, seconds);
}

fulltime(FT) ::= NUM(hours) COLON NUM(minutes) COLON NUM(seconds) DOT NUM(milliseconds) SPACE AM SPACE.
{
    /* English fulltime - am */
    FT = (char *) malloc( sizeof(char) * 16 );
    snprintf(FT, 16, "%s:%s:%s.%s am", hours, minutes, seconds, milliseconds);
}

fulltime(FT) ::= NUM(hours) COLON NUM(minutes) COLON NUM(seconds) SPACE AM SPACE.
{
    /* English fulltime - am */
    FT = (char *) malloc( sizeof(char) * 16 );
    snprintf(FT, 16, "%s:%s:%s am", hours, minutes, seconds);
}

fulltime(FT) ::= NUM(hours) COLON NUM(minutes) COLON NUM(seconds) DOT NUM(milliseconds) SPACE PM SPACE.
{
    /* English fulltime - pm */
    FT = (char *) malloc( sizeof(char) * 16 );
    snprintf(FT, 16, "%s:%s:%s.%s pm", hours, minutes, seconds, milliseconds);
}

fulltime(FT) ::= NUM(hours) COLON NUM(minutes) COLON NUM(seconds) SPACE PM SPACE.
{
    /* English fulltime - pm */
    FT = (char *) malloc( sizeof(char) * 16 );
    snprintf(FT, 16, "%s:%s:%s pm", hours, minutes, seconds);
}
