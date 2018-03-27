test_verdict(V) ::= FAILED.
{
    V = (char *) malloc( sizeof(char) * 10);
    snprintf(V, 10, "Failed");
}

test_verdict(V) ::= PASSED.
{
    V = (char *) malloc( sizeof(char) * 10);
    snprintf(V, 10, "Passed");
}

test_module(M) ::= test_verdict(V) COLON SPACE TEST SPACE MODULE.
{
    M = (char *) malloc( sizeof(char) * 30);
    snprintf(M, 30, "%s: Test module", V);
}

test_module(M) ::= TEST SPACE MODULE.
{
    M = (char *) malloc( sizeof(char) * 30);
    snprintf(M, 30, "Test module");
}

test_status(S) ::= STARTED DOT.
{
    S = (char *) malloc( sizeof(char) * 20);
    snprintf(S, 20, "started.");
}

test_status(S) ::= FINISHED DOT.
{
    S = (char *) malloc( sizeof(char) * 20);
    snprintf(S, 20, "finished.");
}

tfs_event_text(T) ::= TEST SPACE CONFIGURATION SPACE SQSTR(config) COMMA SPACE TEST SPACE UNIT SPACE SQSTR(unit) COLON SPACE TEST SPACE CASE SPACE SQSTR(case) SPACE test_status(status).
{
    T = (char *) malloc( sizeof(char) * 256);
    snprintf(T, 256, "Test configuration %s, Test unit %s: Test case %s %s.", config, unit, case, status);
}

tfs_event_text(T) ::= test_verdict(verdict) TEST SPACE CONFIGURATION SPACE SQSTR(config) COMMA SPACE TEST SPACE UNIT SPACE SQSTR(unit) COLON SPACE TEST SPACE CASE SPACE SQSTR(case) SPACE test_status(status).
{
    T = (char *) malloc( sizeof(char) * 256);
    snprintf(T, 256, "%s: Test configuration %s, Test unit %s: Test case %s %s.", verdict, config, unit, case, status);
}

// You cannot have a name in parens that matches a token!!
tfs_event_text(T) ::= test_module(M) SPACE SQSTR(module) COLON SPACE TEST SPACE CASE SPACE SQSTR(test_case) SPACE test_status(S).
{
    T = (char *) malloc( sizeof(char) * 256);
    snprintf(T, 256, "%s %s: Test case %s %s", M, module, test_case, S);
}

tfs_event_text(T) ::= test_module(M) SPACE SQSTR(module) SPACE test_status(S).
{
    T = (char *) malloc( sizeof(char) * 256);
    snprintf(T, 256, "%s %s %s", M, module, S);
}

tfs_event_text(T) ::= test_module(M) SPACE SQSTR(module).
{
    T = (char *) malloc( sizeof(char) * 256);
    snprintf(T, 256, "%s %s", M, module);
}

tfs_event ::= time(S) SPACE TFS COLON SPACE LBRACKET NUM(execID) COMMA NUM(elementID) RBRACKET SPACE tfs_event_text(T).
{
    fprintf(state->output, "%s TFS: [%s,%s] %s\n", S, execID, elementID, T);  
}