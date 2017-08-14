//
//  MagicLogFormatter.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/14.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "MagicLogFormatter.h"

@implementation MagicLogFormatter

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage{
    
    NSString *loglevel = nil;
    switch (logMessage.flag){
        case LOG_FLAG_ERROR:
            loglevel = @"[ERROR]--->";
            break;
        case LOG_FLAG_WARN:
            loglevel = @"[WARN]--->";
            break;
        case LOG_FLAG_INFO:
            loglevel = @"[INFO]--->";
            break;
        case LOG_FLAG_DEBUG:
            loglevel = @"[DEBUG]--->";
            break;
        case LOG_FLAG_VERBOSE:
            loglevel = @"[VBOSE]--->";
            break;
        default:
            break;
    }
    NSString *resultString = [NSString stringWithFormat:@"%@ %@___line[%ld]__%@", loglevel, logMessage->_function, logMessage->_line, logMessage->_message];
    return resultString;
    
}
@end
