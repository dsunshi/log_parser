// Start of measurement | Start der Messung
start       = "Start";
of          = "of";
der         = "der";
measurement = "measurement";
messung     = "Messung";

// CAN Events
can         = "CAN";
can_fd      = "CAN FD";
canfd       = "CANFD";
rx          = "rx";
// TODO: This is a hack to resolve parser conflicts.
status      = [ ]+ "status" | [ ]+ "Status";
statistic   = [ ]+ "Statistic";

// CAN Error Event
txerr       = "TxErr";
rxerr       = "RxErr";
chip        = "chip";
error       = "error";
warning     = "warning";
level       = "level";
active      = "active";
queue       = "queue";
overrun     = "overrun";

// CAN Bus Statistics
d           = "D";
r           = "R";
xd          = "XD";
xr          = "XR";
e           = "E";
o           = "O";
b           = "B";

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
//  #tools.simple_token("canfd")
//  tools.simple_token("statistic")
//  tools.simple_token("queue")
//  tools.simple_token("overrun")
//  tools.simple_token("d")
//  tools.simple_token("r")
//  tools.simple_token("xd")
//  tools.simple_token("xr")
//  tools.simple_token("e")
//  tools.simple_token("o")
//  tools.simple_token("b")
//]]]
//[[[end]]]