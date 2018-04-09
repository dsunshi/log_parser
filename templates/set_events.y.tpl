/*[[[cog
import cog
import CogUtils as tools

events = [
#    'EVENT_BUS_CLASSIC',
#    'EVENT_BUS_FD',
#    'EVENT_MSG_STD',
#    'EVENT_MSG_EXT',
#    'EVENT_MSG_FD',
#    'EVENT_CAN_MESSAGE',
#    'EVENT_CAN_REMOTE',
#    'EVENT_CAN_ERROR_FRAME',
#    'EVENT_CAN_STATISTIC',
#    'EVENT_CAN_ERROR',
    'EVENT_GENERAL_DATE',
#    'EVENT_GENERAL_BASE',
#    'EVENT_GENERAL_TIMESTAMPS',
#    'EVENT_GENERAL_EVENT_LOGGING',
#    'EVENT_GENERAL_VERSION',
#    'EVENT_GENERAL_SPLIT',
#    'EVENT_GENERAL_GPS_EVENT',
#    'EVENT_GENERAL_COMMENT_EVENT',
#    'EVENT_GENERAL_GLOBAL_MARKER_EVENT',
#    'EVENT_GENERAL_WATERMARK',
#    'EVENT_VAR_SV',
#    'EVENT_VAR_ENV',
#    'EVENT_VAR_MACRO',
#    'EVENT_TEST_BEGIN',
#    'EVENT_TEST_END',
#    'EVENT_TEST_ABORT',
#    'EVENT_TRIGGER_BLOCK_BEGIN',
#    'EVENT_TRIGGER_BLOCK_END'
]

for event in events:
    cog.outl("set_%s ::= ." % event.lower())
    cog.outl("{")
    cog.outl("    state->event_type = %s;" % event)
    cog.outl("    printf(\"Event: %s\\n\");" % event)
    cog.outl("}")

]]]*/
/*[[[end]]]*/
