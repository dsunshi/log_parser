
/* Date 
 * Definition: date <WeekDay> <Month> <Date> <Fulltime> <Year>
*/
date ::= DATE SPACE time_and_date(TD).
{
    /* Date line */
    fprintf(state->output, "date %s\n", TD);
}

time_and_date(TD) ::= WEEKDAY(weekday) SPACE MONTH(month) SPACE DEC(day_of_month) SPACE fulltime(timestamp) DEC(year).
{
    TD = (char *) malloc( sizeof(char) * 37 );
    snprintf(TD, 37, "%s %s %s %s %s", weekday, month, day_of_month, timestamp, year);
}

/*
 * Definition:  fulltime
 * Description: HH:MM:SS.MILLIS (am|pm)
 */
fulltime(FT) ::= DEC(hours) COLON DEC(minutes) COLON DEC(seconds) DOT DEC(milliseconds) SPACE.
{
    /* German fulltime (no am or pm) */
    //printf("de    fulltime: %s:%s:%s.%s\n", hours, minutes, seconds, milliseconds);
    FT = (char *) malloc( sizeof(char) * 13 );
    snprintf(FT, 13, "%s:%s:%s.%s", hours, minutes, seconds, milliseconds);
}

fulltime(FT) ::= DEC(hours) COLON DEC(minutes) COLON DEC(seconds) DOT DEC(milliseconds) SPACE AM SPACE.
{
    /* English fulltime - am */
    //printf("en-am fulltime: %s:%s:%s.%s\n", hours, minutes, seconds, milliseconds);
    FT = (char *) malloc( sizeof(char) * 16 );
    snprintf(FT, 16, "%s:%s:%s.%s am", hours, minutes, seconds, milliseconds);
}

fulltime(FT) ::= DEC(hours) COLON DEC(minutes) COLON DEC(seconds) DOT DEC(milliseconds) SPACE PM SPACE.
{
    /* English fulltime - pm */
    //printf("en-pm fulltime: %s:%s:%s.%s\n", hours, minutes, seconds, milliseconds);
    FT = (char *) malloc( sizeof(char) * 16 );
    snprintf(FT, 16, "%s:%s:%s.%s pm", hours, minutes, seconds, milliseconds);
}
