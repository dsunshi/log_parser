/* Triggerblock */

begin_triggerblock ::= set_event_trigger_block_begin BEGIN SPACE TRIGGERBLOCK.
{
    fprintf(state->output, "Begin Triggerblock\n");
}

begin_triggerblock ::= set_event_trigger_block_begin BEGIN SPACE TRIGGERBLOCK SPACE time_and_date(TD).
{
    fprintf(state->output, "Begin Triggerblock %s\n", TD);
}

end_triggerblock ::= set_event_trigger_block_end END SPACE TRIGGERBLOCK.
{
    fprintf(state->output, "End TriggerBlock\n");
}