sv_event ::= time(S) SPACE SV COLON SPACE frame_data(info) SPACE COLON COLON IDENTIFIER(variable) SPACE EQUALS SPACE frame_data(values).
{
    fprintf(state->output, "%s SV: %s ::%s = %s\n", S, info, variable, values); 
}