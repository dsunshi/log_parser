watermark ::= time(S) SPACE EXCLAMATION SPACE QUEUE COLON SPACE LOWWATERMARK DOT.
{
    fprintf(state->output, "%s ! Queue: LowWaterMark.\n", S); 
}

watermark ::= time(S) SPACE EXCLAMATION SPACE QUEUE COLON SPACE HIGHWATERMARK DOT.
{
    fprintf(state->output, "%s ! Queue: HighWaterMark.\n", S); 
}
