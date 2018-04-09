watermark ::= time(S) SPACE set_event_general_watermark EXCLAMATION SPACE QUEUE COLON SPACE LOWWATERMARK DOT.
{
    fprintf(state->output, "%s ! Queue: LowWaterMark.\n", S); 
}

watermark ::= time(S) SPACE set_event_general_watermark EXCLAMATION SPACE QUEUE COLON SPACE HIGHWATERMARK DOT.
{
    fprintf(state->output, "%s ! Queue: HighWaterMark.\n", S); 
}
