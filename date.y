
/* Date 
 * Definition: date <WeekDay> <Month> <Date> <Fulltime> <Year>
*/
line ::= DATE WEEKDAY(D) MONTH(M) NUM(T) fulltime NUM(Y) NEWLINE.
{
    /* Date line */
    printf("date: %s %s %d <Fulltime> %d\n", D, M, T, Y);
}

/*
 * Definition:  fulltime
 * Description: HH:MM:SS.MILLIS (am|pm)
 */
fulltime(TS) := NUM(H) COLON NUM(M) COLON NUM(S) DOT NUM(MS).
{
    /* German fulltime (no am or pm) */
    printf("de    fulltime: %d:%d:%d.%d\n", H, M, S, MS);
}

fulltime(TS) := NUM(H) COLON NUM(M) COLON NUM(S) DOT NUM(MS) AM.
{
    /* English fulltime - am */
    printf("en-am fulltime: %d:%d:%d.%d\n", H, M, S, MS);
}

fulltime(TS) := NUM(H) COLON NUM(M) COLON NUM(S) DOT NUM(MS) PM.
{
    /* English fulltime - pm */
    printf("en-pm fulltime: %d:%d:%d.%d\n", H, M, S, MS);
}

/* date_stamp ::= DAY MONTH NUM NUM COLON NUM COLON positive_ts ampm NUM. {}  */
/* date_stamp ::= DAY MONTH NUM NUM COLON NUM COLON NUM NUM. {} */
/* date_stamp ::= DAY MONTH NUM NUM COLON NUM COLON NUM ampm NUM. {} */