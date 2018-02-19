
/* Date 
 * Definition: date <WeekDay> <Month> <Date> <Fulltime> <Year>
*/
date ::= DATE SPACE WEEKDAY(weekday) SPACE MONTH(month) SPACE DEC(day_of_month) SPACE fulltime(timestamp) DEC(year).
{
    /* Date line */
    printf("date: %s %s %s %s %s\n", weekday, month, day_of_month, timestamp, year);
}

/*
 * Definition:  fulltime
 * Description: HH:MM:SS.MILLIS (am|pm)
 */
fulltime(FT) ::= DEC(hours) COLON DEC(minutes) COLON DEC(seconds) DOT DEC(milliseconds) SPACE.
{
    /* German fulltime (no am or pm) */
    //printf("de    fulltime: %s:%s:%s.%s\n", hours, minutes, seconds, milliseconds);
    FT = (char *) malloc( sizeof(char) * 12 );
    snprintf(FT, 12, "%s:%s:%s.%s", hours, minutes, seconds, milliseconds);
    
}

fulltime(FT) ::= DEC(hours) COLON DEC(minutes) COLON DEC(seconds) DOT DEC(milliseconds) SPACE AM SPACE.
{
    /* English fulltime - am */
    //printf("en-am fulltime: %s:%s:%s.%s\n", hours, minutes, seconds, milliseconds);
    FT = (char *) malloc( sizeof(char) * 12 );
    snprintf(FT, 12, "%s:%s:%s.%s", hours, minutes, seconds, milliseconds);
}

fulltime(FT) ::= DEC(hours) COLON DEC(minutes) COLON DEC(seconds) DOT DEC(milliseconds) SPACE PM SPACE.
{
    /* English fulltime - pm */
    //printf("en-pm fulltime: %s:%s:%s.%s\n", hours, minutes, seconds, milliseconds);
    FT = (char *) malloc( sizeof(char) * 12 );
    snprintf(FT, 12, "%s:%s:%s.%s", hours, minutes, seconds, milliseconds);
}

/* date_stamp ::= DAY MONTH NUM NUM COLON NUM COLON positive_ts ampm NUM. {}  */
/* date_stamp ::= DAY MONTH NUM NUM COLON NUM COLON NUM NUM. {} */
/* date_stamp ::= DAY MONTH NUM NUM COLON NUM COLON NUM ampm NUM. {} */