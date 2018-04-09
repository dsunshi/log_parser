/* CAN Events on a Classic CAN bus */
dir(D) ::= RX.
{
    D = (char *) malloc( sizeof(char) * 3 );
    snprintf(D, 3, "Rx");
}

dir(D) ::= TX.
{
    D = (char *) malloc( sizeof(char) * 3 );
    snprintf(D, 3, "Tx");
}

dir(D) ::= TXRQ.
{
    D = (char *) malloc( sizeof(char) * 5 );
    snprintf(D, 5, "TxRq");
}