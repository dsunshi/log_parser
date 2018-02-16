
/* Date 
 * Definition: date <WeekDay> <Month> <Date> <Fulltime> <Year>
*/
date ::= DATE SPACE WEEKDAY(D) SPACE MONTH(M) SPACE DEC(T) SPACE fulltime(FT) DEC(Y) NEWLINE.
{
    /* Date line */
    printf("date: %s %s %s %s %s\n", D.buffer, M.buffer, T.buffer, FT.buffer, Y.buffer);
}

/*
 * Definition:  fulltime
 * Description: HH:MM:SS.MILLIS (am|pm)
 */
fulltime(FT) ::= DEC(H) COLON DEC(M) COLON DEC(S) DOT DEC(MS) SPACE.
{
    /* German fulltime (no am or pm) */
    //printf("de    fulltime: %s:%s:%s.%s\n", H.buffer, M.buffer, S.buffer, MS.buffer);
    FT.buffer = (char *) malloc( sizeof(char) * 12 );
    snprintf(FT.buffer, 12, "%s:%s:%s.%s", H.buffer, M.buffer, S.buffer, MS.buffer);
    
}

fulltime(FT) ::= DEC(H) COLON DEC(M) COLON DEC(S) DOT DEC(MS) SPACE AM SPACE.
{
    /* English fulltime - am */
    //printf("en-am fulltime: %s:%s:%s.%s\n", H.buffer, M.buffer, S.buffer, MS.buffer);
    FT.buffer = (char *) malloc( sizeof(char) * 12 );
    snprintf(FT.buffer, 12, "%s:%s:%s.%s", H.buffer, M.buffer, S.buffer, MS.buffer);
}

fulltime(FT) ::= DEC(H) COLON DEC(M) COLON DEC(S) DOT DEC(MS) SPACE PM SPACE.
{
    /* English fulltime - pm */
    //printf("en-pm fulltime: %s:%s:%s.%s\n", H.buffer, M.buffer, S.buffer, MS.buffer);
    FT.buffer = (char *) malloc( sizeof(char) * 12 );
    snprintf(FT.buffer, 12, "%s:%s:%s.%s", H.buffer, M.buffer, S.buffer, MS.buffer);
}

/* date_stamp ::= DAY MONTH NUM NUM COLON NUM COLON positive_ts ampm NUM. {}  */
/* date_stamp ::= DAY MONTH NUM NUM COLON NUM COLON NUM NUM. {} */
/* date_stamp ::= DAY MONTH NUM NUM COLON NUM COLON NUM ampm NUM. {} */