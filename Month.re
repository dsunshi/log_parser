// A string that represents a month.
// month = English | German
jan = "Jan";
feb = "Feb";
mar = "Mar" | "M\u0228r";
apr = "Apr";
may = "May" | "Mai";
jun = "Jun";
jul = "Jul";
aug = "Aug";
sep = "Sep";
oct = "Oct" | "Okt";
nov = "Nov";
dec = "Dec" | "Dez";
Month = jan | feb | mar | apr | may | jun | jul | aug | sep | oct | nov | dec;

//[[[cog
//  import CogUtils as tools
//  tools.create_token("Month", "MONTH", 3)
//]]]
//[[[end]]]