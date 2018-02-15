
#include "../munit/munit.h"
#include "tests.h"

#define NUM_DATE_LINES 1000

const char * day_en[7] =
{
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun" 
};

const char * day_de[7] =
{
    "Mon",
    "Die",
    "Mit",
    "Don",
    "Fre",
    "Sam",
    "Son" 
};

const char * month_en[12] =
{
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
};

const char * month_de[12] =
{
    "Jan",
    "Feb",
    "M\u0228r",
    "Apr",
    "Mai",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Okt",
    "Nov",
    "Dez"
};

MunitResult test_date_lex(const MunitParameter params[], void* user_data)
{
    /*
     * Basic format of the date:
     * date Tue Feb 7 02:03:20.010 pm 2017
     *
     * In the Englisch version the first number is 0 to 12 and am/pm are used.
     * In the German version the first number ranges from 0 to 23 and am/pm are NOT used.
     */
    bool english;

    char * day;
    char * month;
    unsigned int date;
    unsigned int hours;
    unsigned int minutes;
    unsigned int seconds;
    unsigned int ms;
    char * ampm;
    unsigned int year;
    int index;
    
    yyinput_t * input = NULL;
    int token;
    
    FILE * file = NULL;
    
    file = fopen("date.txt", "w");
    
    munit_assert_not_null(file);
    
    for (index = 0; index < NUM_DATE_LINES; index++)
    {
        english = (bool) munit_rand_int_range(0, 1);
        
        /* English/German independent */
        date    = munit_rand_int_range(1, 31);
        year    = munit_rand_int_range(1900, 2018);
        minutes = munit_rand_int_range(0, 60);
        seconds = munit_rand_int_range(0, 60);
        ms      = munit_rand_int_range(0, 999);
        
        if (english)
        {
            hours = munit_rand_int_range(0, 12);
            day   = day_en[munit_rand_int_range(0, 6)];
            month = month_en[munit_rand_int_range(0, 11)];
            ampm  = munit_rand_int_range(0, 1) == 1 ? "am" : "pm";
            
            fprintf(file, "date %s %s %02d %02d:%02d:%02d.%03d %s %04d\n",
                    day, month, date, hours, minutes, seconds, ms, ampm, year);
        }
        else
        {
            /* German */
            hours = munit_rand_int_range(0, 23);
            day   = day_de[munit_rand_int_range(0, 6)];
            month = month_de[munit_rand_int_range(0, 11)];
            ampm  = "";
            
            fprintf(file, "date %s %s %02d %02d:%02d:%02d.%03d %04d\n",
                    day, month, date, hours, minutes, seconds, ms, year);
        }
    }
    
    fclose( file );
    
    input = create_lexer(fopen("date.txt", "r"), 4096, YYMAXFILL);
    
    munit_assert_not_null(input);
    
    do
    {
        token = lex(input);
        munit_assert_int(token, !=, TOKEN_UNKOWN);
    } while (token > 0);
    
    fclose( file );
    
    return MUNIT_OK;
}
