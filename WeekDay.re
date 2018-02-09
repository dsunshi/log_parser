// A string that represents a day of the week.
// day = English | German
mon = "Mon";
tue = "Tue" | "Die";
wed = "Wed" | "Mit";
thu = "Thu" | "Don";
fri = "Fri" | "Fre";
sat = "Sat" | "Sam";
sun = "Sun" | "Son";
WeekDay = mon | tue | wed | thu | fri | sat | sun;

//[[[cog
//  import CogUtils as tools
//  tools.create_token("WeekDay", "WEEKDAY")
//]]]
//[[[end]]]