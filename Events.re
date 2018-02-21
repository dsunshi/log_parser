// Start of measurement | Start der Messung
start       = "Start";
of          = "of";
der         = "der";
measurement = "measurement";
messung     = "Messung";

// CAN Events
can         = "CAN";
can_fd      = "CAN FD";
rx          = "rx";
status      = "status" | "Status";

// CAN Error Event
txerr       = "TxErr";
rxerr       = "RxErr";
chip        = "chip";
error       = "error";
warning     = "warning";
level       = "level";
active      = "active";

//[[[cog
//  import CogUtils as tools
//  tools.simple_token("start")
//  tools.simple_token("of")
//  tools.simple_token("der")
//  tools.simple_token("measurement")
//  tools.simple_token("messung")
//  tools.simple_token("can")
//  tools.simple_token("rx")
//  tools.simple_token("status")
//  tools.simple_token("txerr")
//  tools.simple_token("rxerr")
//  tools.simple_token("chip")
//  tools.simple_token("error")
//  tools.simple_token("warning")
//  tools.simple_token("level")
//  tools.simple_token("active")
//  tools.simple_token("can_fd")
//]]]
//[[[end]]]