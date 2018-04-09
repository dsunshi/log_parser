/* Triggerblock */

begin_triggerblock ::= BEGIN SPACE TRIGGERBLOCK.
{
    fprintf(state->output, "Begin Triggerblock\n");
}

begin_triggerblock ::= BEGIN SPACE TRIGGERBLOCK SPACE time_and_date(TD).
{
    fprintf(state->output, "Begin Triggerblock %s\n", TD);
}

end_triggerblock ::= END SPACE TRIGGERBLOCK.
{
    fprintf(state->output, "End TriggerBlock\n");
}