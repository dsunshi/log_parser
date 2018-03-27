id(ID) ::= NUM(msg_id).
{
    ID = (char *) malloc( sizeof(char) * 10 );
    snprintf(ID, 10, "%s", msg_id);
}

id(ID) ::= EXTENDED(msg_id).
{
    ID = (char *) malloc( sizeof(char) * 11 );
    snprintf(ID, 11, "%s", msg_id);
}

/*[[[cog
import cog
import CogUtils as tools

for bytes_per_msg in range(0, 8):
    cog.out( "can_message_data(message_data) ::= time(T) SPACE channel(C) SPACE id(message_id) SPACE dir(D) SPACE D SPACE NUM(dlc)" )
    bytes = ""
    for byte_in_msg in range(0, bytes_per_msg + 1):
        cog.out(" SPACE NUM(byte_%s)" % byte_in_msg)
        bytes += ", byte_%s" % byte_in_msg
    cog.outl(".\n{")
    cog.outl("\tsize_t length = strlen(T) + strlen(C) + strlen(message_id) + strlen(D) + strlen(dlc) + 10 + (2 * %s);" % (bytes_per_msg + 1))
    cog.outl("\tmessage_data = (char *) malloc( sizeof(char) * length );")
    cog.outl("\tsnprintf(message_data, length, \"%%s %%s %%s %%s d %%s %s\", T, C, message_id, D, dlc%s);" % ("%s " * (bytes_per_msg + 1), bytes) )
    cog.outl("}\n")
]]]*/
/*[[[end]]]*/

can_message_info(message_info) ::= LENGTH SPACE EQUALS SPACE NUM(message_duration) SPACE BITCOUNT SPACE EQUALS SPACE NUM(message_length) SPACE ID SPACE EQUALS SPACE id(id_num).
{
    message_info = (char *) malloc( sizeof(char) * 100 );
    snprintf(message_info, 100, "Length = %s BitCount = %s ID = %s", message_duration, message_length, id_num);
}

can_message_info(message_info) ::= LENGTH SPACE EQUALS SPACE NUM(message_duration) SPACE BITCOUNT SPACE EQUALS SPACE NUM(message_length).
{
    message_info = (char *) malloc( sizeof(char) * 100 );
    snprintf(message_info, 100, "Length = %s BitCount = %s", message_duration, message_length);
}

can_message ::= can_message_data(message_data).
{
    fprintf(state->output, "%s\n", message_data);
}

can_message ::= can_message_data(message_data) SPACE can_message_info(message_info).
{
    fprintf(state->output, "%s %s\n", message_data, message_info);
}