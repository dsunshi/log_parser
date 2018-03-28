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

can_message_data(message_data) ::= time(T) SPACE channel(C) SPACE id(message_id) SPACE dir(D) SPACE D SPACE NUM(dlc) SPACE NUM(d0) SPACE frame_data(data).
{
	size_t length = strlen(T) + strlen(C) + strlen(message_id) + strlen(D) + strlen(dlc) + 2 + strlen(data) + 50;
	message_data = (char *) malloc( sizeof(char) * length );
	snprintf(message_data, length, "%s %s %s %s d %s %s %s ", T, C, message_id, D, dlc, d0, data);
}

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

can_message ::= can_message_data(message_data) can_message_info(message_info).
{
    fprintf(state->output, "%s %s\n", message_data, message_info);
}

/* CAN Events on CAN FD channel */
/* <Time> CANFD <Channel> <Dir> <ID> <SymbolicName> <BRS> <ESI> <DLC> <DataLength> <D1> … <D8> <MessageDuration> <MessageLength> <Flags> <CRC> <BitTimingConfArb> <BitTimingConfData> <BitTimingConfExtArb> <BitTimingConfExtData> */
/* <Time> CANFD <Channel> <Dir> <ID> <SymbolicName> <BRS> <ESI> <DLC> <DataLength> <D1> … <D8> <MessageDuration> <MessageLength> <Flags> <CRC> <BitTimingConfArb> <BitTimingConfData>> <BitTimingConfData> <Bit-TimingConfExtArb> <BitTimingConfExtData> */
