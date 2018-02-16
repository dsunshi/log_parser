
#include "lexer.h"
#include "parser.h"

/* Create a lexer for the provided file */
yyinput_t * create_lexer(FILE * file, const size_t size, const size_t maxfill)
{
	yyinput_t * input = NULL;

	input = (yyinput_t *) malloc(sizeof(yyinput_t));

	if (input == NULL)
	{
        /* Unable to allocate enough memory for the lexer */
	}
	else
	{
		memset(input, 0x00, sizeof(yyinput_t));

		input->buffer = (iutf8_t *) malloc(sizeof(iutf8_t) * (size + maxfill));

		if (input->buffer == NULL)
		{
            /* Unable to allocate enough memory for the actual string buffer used by the lexer */
		}
		else
		{
			memset(input->buffer, 0x00, (size + maxfill));

	    	input->limit   = input->buffer + size;
   			input->cursor  = input->limit;
    		input->token   = input->limit;
    		input->eof     = false;
    		input->size    = size;
    		input->maxfill = maxfill;
    		input->file    = file;
		}
	}
    
    return input;
}

/* Get the value of the current token from within the lexers buffer */
void get_token_value(yyinput_t * input, YYSTYPE * output)
{
    size_t length = input->cursor - input->token;
    strncpy( output->buffer, input->token, length );
    output->buffer[length] = '\0';
}

void destroy_lexer(yyinput_t * lexer)
{
    free(lexer->buffer);
    free(lexer);
}

/* Explaination of fill - taken directly from: http://re2c.org/examples/example_03.html
 *
 * The idea of YYFILL is fairly simple: the lexer is stuck upon the fact that (YYLIMIT - YYCURSOR) < n
 * and YYFILL must either invert this condition or stop lexing. A disaster will happen if YYFILL fails to provide
 * at least n characters, yet resumes lexing. Technically YYFILL must somehow "extend" the input by
 * at least n characters: after YYFILL, all input pointers must point to the exact same characters, except YYLIMIT,
 * which must be advanced at least n positions. Since we want to use a fixed amount of memory,
 * we have to shift buffer contents: discard characters that have already been lexed, move the
 * remaining characters to the beginning of the buffer, and fill the vacant space with new characters.
 * All the pointers must be decreased by the length of the discarded input,
 * except YYLIMIT (it must point at the end of buffer).
 */
bool fill(yyinput_t * input, const size_t need)
{
    const size_t remaining = input->token - input->buffer;
    size_t nread;
    
    if (input->eof != false)
    {
        return false;
    }
    else if (remaining < need)
    {
        return false;
    }
    else
    {
        /* buffer is the entire memory buffer
           token  is the location of the current char within buffer
           (limit - token) is the amount of remaining unprocessed data that will be move from the current
           location (token) to the start of the buffer so processing can continue.
         */
        memmove(input->buffer, input->token, input->limit - input->token);
        input->limit  -= remaining;
        input->cursor -= remaining;
        input->token  -= remaining;
        
        nread = fread(input->limit, (size_t) 1, remaining, input->file);
        input->limit += nread; 
        
        if (nread < remaining)
        {
            /* Either we've reached the end of the input file, or failed to read enough data to continue,
             * in both cases we're done here...
             */
            input->eof = true;
            memset(input->limit, 0x00, input->maxfill);
            input->limit += input->maxfill;
        }
        
        return true;
    }
}
//unsigned char fill(yyinput_t * input, const size_t need)
//{
//    const size_t remaining = input->token - input->buffer;
//    unsigned char result   = 0;
//    size_t nread;
//    static unsigned char comment_counter = 0;
//
//    //printf("filling %d\n", need);
//
//    if (input->file == NULL)
//    {
//    	printf("no open file\n");
//    }
//
//    if ( (input->eof != 0) || (remaining < need) )
//    {
//        //printf("************ error *************\n");
//        //printf("remaining: %d\n", remaining);
//        //printf("need:      %d\n", need);
//        //printf("limit: %d\n", input->limit);
//        //printf("size: %d\n", input->buffer + input->size);
//        //printf("eof: %d\n", input->eof);
//        //printf("|%s|\n", input->buffer);
//        //printf("|%s|\n", input->token);
//        //printf("|%s|\n", input->cursor);
//        //exit(-1);
//        //input->limit += 1;
//
//        if (strlen(input->token)==0 && comment_counter > 0)
//        {
//            *input->cursor = '\00';
//                result = 1;
//        }
//
//        if ( (need == 1) && (remaining == 0) && (strncmp(input->buffer, input->token, strlen(input->buffer)) == 0) )
//        {
//
//        //    *input->buffer= '\n';
//        //    *input->token = '\n';
//            if (comment_counter == 0)
//            {
//                //printf("NEWLINE\n");
//                *input->cursor = '\n';
//                result = 1;
//            }
//            if (comment_counter == 1)
//            {
//                //printf("NULL\n");
//                *input->cursor = '\00';
//                result = 1;
//            }
//
//            comment_counter++;
//        }
//    }
//    else
//    {
//        /* buffer is the entire memory buffer
//           token  is the location of the current char within buffer
//           (limit - token) is the number of remaining unprocessed data
//           */
//        memmove(input->buffer, input->token, input->limit - input->token);
//
//        input->limit  -= remaining;
//        input->cursor -= remaining;
//        input->token  -= remaining;
//
//        //printf("reading: %d\n", remaining);
//        nread  = fread(input->limit, 1, remaining, input->file);
//        input->limit += nread;      
//
//        //if (input->limit < (input->buffer + input->size))
//        if (nread < remaining)
//        {
//
//            //printf("limit: %d\n", input->limit);
//            input->eof = 1;
//            memset(input->limit , 0, input->maxfill);
//            input->limit += input->maxfill;
//        }
//        else
//        {
//
//        }
//
//        result = 1;
//    }
//
//    return result;
//}

int exit_success(yyinput_t * input)
{
	int result = LEXER_EXIT_ERROR;

	if (input->maxfill == ((size_t) (input->limit - input->token)))
	{
        /* The current token is exaclty at the end of the input buffer. So if we have lexed to an end we have
         * sucessfully lexed the entire input.
         */
		result = TOKEN_END;
        //input->eof = 0;
	}
	else
	{
        
	}
	
	return result;
}