// Start of measurement | Start der Messung
start       = "Start" | "start"; // lowercase for log events
of          = "of";
der         = "der";
measurement = "measurement";
messung     = "Messung";

// CAN Events
can         = "CAN";
can_fd      = "CAN FD";
canfd       = "CANFD";
rx          = "rx" | "Rx";
tx          = "tx" | "Tx";
txrq        = "TxRq";

status      = "status" | "Status";
statistic   = "Statistic";

// CAN Error Frame
errorframe  = "ErrorFrame";

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
d           = "D" | "d";
r           = "R";
xd          = "XD";
xr          = "XR";
e           = "E";
o           = "O";
b           = "B";

// Log and Trigger Events
ms          = "ms";
trigger     = "trigger";
event       = "event";
stop        = "stop";
direct      = "direct";
log_comment = "(" ([a-zA-Z_]+ | [a-zA-Z_][a-zA-Z_0-9 ]*) .* ")";

// CAN Message Events
length      = "Length";
bitcount    = "BitCount";
id          = "ID";

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
//  tools.simple_token("ms")
//  tools.simple_token("trigger")
//  tools.simple_token("event")
//  tools.simple_token("stop")
//  tools.simple_token("direct")
//  tools.simple_token("tx")
//  tools.simple_token("txrq")
//  tools.simple_token("length")
//  tools.simple_token("bitcount")
//  tools.simple_token("id")
//  tools.simple_token("errorframe")
//  tools.simple_token("log_comment")
//]]]
//[[[end]]]