//
//  MagicLogManager.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/14.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

//开源依赖
#if DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelWarning;
#endif

@interface MagicLogManager : NSObject

@property(nonatomic, strong)DDFileLogger *fileLogger;

+ (MagicLogManager *)shareManager;
- (void)start;                              // 配置日志信息
- (NSArray *)getAllLogFilePath;             // 获取日志路径
- (NSArray *)getAllLogFileContent;          // 获取日志内容

/*
// 产生Log示例
DDLogVerbose(@"Verbose");    // 详细日志
DDLogDebug(@"Debug");        // 调试日志
DDLogInfo(@"Info");          // 信息日志
DDLogWarn(@"Warn");          // 警告日志
DDLogError(@"Error");        // 错误日志
*/
@end
