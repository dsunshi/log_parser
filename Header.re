// data indicates time the log was created.
date = "date";
// am or pm. Note: this is only used in the English version and not the German version.
am = "am";
pm = "pm";
// base indicates the number system in which values are logged. It can be in hexadecimal or decimal notation.
base        = "base";
hexadecimal = "hex";
decimal     = "dec";
// timestamps indicates whether the timestamps are written absolute to the start of the measurement
// or relative to the preceding event.
no       = "no";
internal = "internal";
events   = "events";
logged   = "logged";

//[[[cog
//  import CogUtils as tools
//  tools.create_token("date",        "DATE")
//  tools.create_token("am",          "AM")
//  tools.create_token("pm",          "PM")
//  tools.create_token("base",        "BASE")
//  tools.create_token("hexadecimal", "HEXADECIMAL")
//  tools.create_token("decimal",     "DECIMAL")
//  tools.create_token("no",          "NO")
//  tools.create_token("internal",    "INTERNAL")
//  tools.create_token("events",      "EVENTS")
//  tools.create_token("logged",      "LOGGED")
//]]]
//[[[end]]]