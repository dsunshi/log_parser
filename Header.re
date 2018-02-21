// data indicates time the log was created.
date         = "date";

// am or pm. Note: this is only used in the English version and not the German version.
am           = "am";
pm           = "pm";

// base indicates the number system in which values are logged. It can be in hexadecimal or decimal notation.
base         = "base";
hexadecimal  = "hex";
decimal      = "dec";

// timestamps indicates whether the timestamps are written absolute to the start of the measurement
// or relative to the preceding event.
timestamps   = "timestamps";
absolute     = "absolute";
relative     = "relative";

// internal events logged indicate whether internal events were logged or not.
no           = "no";
internal     = "internal";
events       = "events";
logged       = "logged";

// version number
version      = "version";

// split information
previous     = "previous";
log          = "log";
file         = "file";

// trigger block
begin        = "Begin";
end          = "End";
triggerblock = "TriggerBlock" | "Triggerblock";

//[[[cog
//  import CogUtils as tools
//  tools.simple_token("date")
//  tools.simple_token("am")
//  tools.simple_token("pm")
//  tools.simple_token("base")
//  tools.simple_token("hexadecimal")
//  tools.simple_token("decimal")
//  tools.simple_token("timestamps")
//  tools.simple_token("absolute")
//  tools.simple_token("relative")
//  tools.simple_token("no")
//  tools.simple_token("internal")
//  tools.simple_token("events")
//  tools.simple_token("logged")
//  tools.simple_token("version")
//  tools.simple_token("previous")
//  tools.simple_token("log")
//  tools.simple_token("file")
//  tools.simple_token("begin")
//  tools.simple_token("end")
//  tools.simple_token("triggerblock")
//]]]
//[[[end]]]