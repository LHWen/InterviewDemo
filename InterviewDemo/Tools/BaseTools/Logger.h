//
//  Logger.h
//
//  Created by LHWen on 2017/10/17.
//  Copyright © 2017年 LHWen. All rights reserved.
//

#ifndef Logger_h
#define Logger_h

/**
 *  打印日志
 */
#define LogON

#if defined LogON
    #define NSLog(format, ...) do {                                                 \
        fprintf(stderr, "<%s : %d> %s\n",                                           \
        [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
        __LINE__, __func__);                                                        \
        (NSLog)((format), ##__VA_ARGS__);                                           \
        fprintf(stderr, "-------\n");                                               \
    } while (0)
#else
    #define NSLog(format, ...)
#endif

#endif /* Logger_h */
