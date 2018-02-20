
/* Triggerblock */

begin_triggerblock ::= BEGIN SPACE TRIGGERBLOCK.
{
    printf("Begin Triggerblock\n");
}

begin_triggerblock ::= BEGIN SPACE TRIGGERBLOCK SPACE time_and_date(TD).
{
    printf("Begin Triggerblock %s\n", TD);
}

end_triggerblock ::= END SPACE TRIGGERBLOCK.
{
    printf("End TriggerBlock\n");
}