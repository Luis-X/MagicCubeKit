//
//  MagicLogManager.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/14.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "MagicLogManager.h"
#import "MagicLogFormatter.h"

@implementation MagicLogManager

+ (MagicLogManager *)shareManager{    
    static MagicLogManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MagicLogManager alloc] init];
        manager.fileLogger = [[DDFileLogger alloc] init];
        manager.fileLogger.rollingFrequency = 60 * 60 * 24;                 // 刷新频率为24小时
        manager.fileLogger.logFileManager.maximumNumberOfLogFiles = 7;      // 最大文件数量为7个
        manager.fileLogger.maximumFileSize = 1024 * 1024 * 2;               // 最大文件大小

    });
    return manager;
}



/**
 配置日志信息
 */
- (void)start{
    
    // 1.自定义Log格式
    MagicLogFormatter *logFormatter = [[MagicLogFormatter alloc] init];
    
    // 2.DDASLLogger，日志语句发送到苹果文件系统、日志状态发送到Console.app
    [[DDASLLogger sharedInstance] setLogFormatter:logFormatter];
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    
    // 3.DDFileLogger，日志语句写入到文件中（默认路径：Library/Caches/Logs/目录下，文件名为bundleid+空格+日期.log）
    DDFileLogger *fileLogger = [MagicLogManager shareManager].fileLogger;
    [fileLogger setLogFormatter:logFormatter];
    [DDLog addLogger:fileLogger withLevel:DDLogLevelError];        // 错误日志，写到文件中
    
    // 4.DDTTYLogger，日志语句发送到Xcode
    [[DDTTYLogger sharedInstance] setLogFormatter:logFormatter];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];           // 启用颜色区分
    [[DDTTYLogger sharedInstance] setForegroundColor:DDMakeColor(255, 0, 0) backgroundColor:nil forFlag:DDLogFlagError];
    [[DDTTYLogger sharedInstance] setForegroundColor:DDMakeColor(125, 200, 80) backgroundColor:nil forFlag:DDLogFlagInfo];
    [[DDTTYLogger sharedInstance] setForegroundColor:DDMakeColor(200, 100, 200) backgroundColor:nil forFlag:DDLogFlagDebug];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];

}



/**
 获取日志路径(文件名bundleid+空格+日期)
 */
- (NSArray *)getAllLogFilePath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesPath = [paths objectAtIndex:0];
    NSString *logPath = [cachesPath stringByAppendingPathComponent:@"Logs"];
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSError *error = nil;
    NSArray *fileArray = [fileManger contentsOfDirectoryAtPath:logPath error:&error];
    NSMutableArray *result = [NSMutableArray array];
    [fileArray enumerateObjectsUsingBlock:^(NSString *filePath, NSUInteger idx, BOOL * _Nonnull stop) {
        if([filePath hasPrefix:[NSBundle mainBundle].bundleIdentifier]){
            NSString *logFilePath = [logPath stringByAppendingPathComponent:filePath];
            [result addObject:logFilePath];
        }
    }];
    return result;
   
}

/**
 获取日志内容
 */
- (NSArray *)getAllLogFileContent{
    
    NSMutableArray *result = [NSMutableArray array];
    NSArray *logfilePaths = [self getAllLogFilePath];
    [logfilePaths enumerateObjectsUsingBlock:^(NSString *filePath, NSUInteger idx, BOOL * _Nonnull stop) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [result addObject:content];
    }];
    return result;
    
}
@end
