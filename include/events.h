
#ifndef __EVENTS_H_
#define __EVENTS_H_

#define EVENT_BUS_CLASSIC                                 0x1
#define EVENT_BUS_FD                                      0x2
#define EVENT_MSG_STD                                     0x4
#define EVENT_MSG_EXT                                     0x8
#define EVENT_MSG_FD                                      0xC
#define EVENT_CAN_MESSAGE                                 0x10
#define EVENT_CAN_REMOTE                                  0x20
#define EVENT_CAN_ERROR_FRAME                             0x30
#define EVENT_CAN_STATISTIC                               0x40
#define EVENT_CAN_ERROR                                   0x50
#define EVENT_GENERAL_DATE                                0x80
#define EVENT_GENERAL_BASE                                0x100
#define EVENT_GENERAL_TIMESTAMPS                          0x180
#define EVENT_GENERAL_EVENT_LOGGING                       0x200
#define EVENT_GENERAL_VERSION                             0x280
#define EVENT_GENERAL_SPLIT                               0x300
#define EVENT_GENERAL_GPS_EVENT                           0x380
#define EVENT_GENERAL_COMMENT_EVENT                       0x400
#define EVENT_GENERAL_GLOBAL_MARKER_EVENT                 0x480
#define EVENT_GENERAL_WATERMARK                           0x500
#define EVENT_VAR_SV                                      0x800
#define EVENT_VAR_ENV                                     0x1000
#define EVENT_VAR_MACRO                                   0x1800
#define EVENT_TEST_BEGIN                                  0x2000
#define EVENT_TEST_END                                    0x4000
#define EVENT_TEST_ABORT                                  0x6000
#define EVENT_TRIGGER_BLOCK_BEGIN                         0x8000
#define EVENT_TRIGGER_BLOCK_END                           0x10000


#define IS_CAN_FD_MESSAGE_EVENT(x) (((x) & (EVENT_BUS_FD | EVENT_MSG_FD)) == (EVENT_BUS_FD | EVENT_MSG_FD))

#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
} /* extern "C" */
#endif

#endif