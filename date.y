
/* Date 
 * Definition: date <WeekDay> <Month> <Date> <Fulltime> <Year>
*/
line ::= DATE SPACE WEEKDAY(D) SPACE MONTH(M) SPACE DEC(T) SPACE fulltime DEC(Y).
{
    /* Date line */
    printf("date: %s %s %s <Fulltime> %s\n", D.buffer, M.buffer, T.buffer, Y.buffer);
}

/*
 * Definition:  fulltime
 * Description: HH:MM:SS.MILLIS (am|pm)
 */
fulltime ::= DEC(H) COLON DEC(M) COLON DEC(S) DOT DEC(MS) SPACE.
{
    /* German fulltime (no am or pm) */
    printf("de    fulltime: %s:%s:%s.%s\n", H.buffer, M.buffer, S.buffer, MS.buffer);
}

fulltime ::= DEC(H) COLON DEC(M) COLON DEC(S) DOT DEC(MS) SPACE AM SPACE.
{
    /* English fulltime - am */
    printf("en-am fulltime: %s:%s:%s.%s\n", H.buffer, M.buffer, S.buffer, MS.buffer);
}

fulltime ::= DEC(H) COLON DEC(M) COLON DEC(S) DOT DEC(MS) SPACE PM SPACE.
{
    /* English fulltime - pm */
    printf("en-pm fulltime: %s:%s:%s.%s\n", H.buffer, M.buffer, S.buffer, MS.buffer);
}

/* date_stamp ::= DAY MONTH NUM NUM COLON NUM COLON positive_ts ampm NUM. {}  */
/* date_stamp ::= DAY MONTH NUM NUM COLON NUM COLON NUM NUM. {} */
/* date_stamp ::= DAY MONTH NUM NUM COLON NUM COLON NUM ampm NUM. {} */