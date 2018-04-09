id_and_dir(id) ::= id(ID) SPACE dir(D).
{
    id = (char *) malloc( sizeof(char) * 15 );
    snprintf(id, 15, "%s %s", ID, D);
}

id_and_dir(id) ::= dir(D) SPACE id(ID).
{
    id = (char *) malloc( sizeof(char) * 15 );
    snprintf(id, 15, "%s %s", D, ID);
}

dlc_prefix(info) ::= D.
{
    info = (char *) malloc( sizeof(char) * 2 );
    snprintf(info, 2, "D");
}

dlc_prefix(info) ::= NUM(brs) SPACE NUM(esi).
{
    info = (char *) malloc( sizeof(char) * 100 );
    snprintf(info, 100, "%s %s", brs, esi);
}

dlc_length(length) ::= NUM(dlc).
{
    length = (char *) malloc( sizeof(char) * 100 );
    snprintf(length, 100, "%s", dlc);
}

dlc_length(length) ::= NUM(dlc) SPACE NUM(DataLength).
{
    length = (char *) malloc( sizeof(char) * 100 );
    snprintf(length, 100, "%s %s", dlc, DataLength);
}

can_message_base(base_data) ::= time(T) SPACE channel(C) SPACE id_and_dir(id) SPACE dlc_prefix(info) SPACE dlc_length(length).
{
    base_data = (char *) malloc( sizeof(char) * 255 );
    snprintf(base_data, 255, "%s %s %s %s %s", T, C, id, info, length);
}

can_std_message_info(std_info) ::= LENGTH SPACE EQUALS SPACE NUM(message_duration) SPACE BITCOUNT SPACE EQUALS SPACE NUM(message_length).
{
    std_info = (char *) malloc( sizeof(char) * 255 );
    snprintf(std_info, 255, "Length = %s BitCount = %s", message_duration, message_length);
}

can_std_message_info(std_info) ::= LENGTH SPACE EQUALS SPACE NUM(message_duration) SPACE BITCOUNT SPACE EQUALS SPACE NUM(message_length) SPACE ID SPACE EQUALS SPACE id(id_num).
{
    std_info = (char *) malloc( sizeof(char) * 255 );
    snprintf(std_info, 255, "Length = %s BitCount = %s ID = %s", message_duration, message_length, id_num);
}

can_message_info(info) ::= message_flags(flags).
{
    info = (char *) malloc( sizeof(char) * 255 );
    snprintf(info, 255, "%s", flags);
}

can_message_info(info) ::= can_std_message_info(std_info).
{
    info = (char *) malloc( sizeof(char) * 255 );
    snprintf(info, 255, "%s", std_info);
}

can_message_info(info) ::= can_std_message_info(std_info) SPACE message_flags(flags).
{
    info = (char *) malloc( sizeof(char) * 255 );
    snprintf(info, 255, "%s %s", std_info, flags);
}

can_message ::= can_message_base(base_data) NUM(D0) NUM(D1) can_message_info(info).
{
    fprintf(state->output, "%s %s %s %s", base_data, D0, D1, info); 
}