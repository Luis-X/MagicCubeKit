//
//  MagicFileManager.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/7/27.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "MagicFileManager.h"

@implementation MagicFileManager

#pragma 获取路径
/**
 获取根路径
 */
+ (NSString *)pathHomeDirectory
{
    NSString *result = NSHomeDirectory();
    return result;
}

/**
 获取Documents
 */
+ (NSString *)pathDocumentDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *result = [paths objectAtIndex:0];
    return result;
}

/**
 获取Library
 */
+ (NSString *)pathLibraryDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *result = [paths objectAtIndex:0];
    return result;
}

/**
 获取Caches
 */
+ (NSString *)pathCachesDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *result = [paths objectAtIndex:0];
    return result;
}

/**
 获取Temporary
 */
+ (NSString *)pathTemporaryDirectory
{
    NSString *result = NSTemporaryDirectory();
    return result;
}

/**
 获取文件路径
 */
+ (NSString *)pathDocumentDirectoryWithFolder:(NSString *)folder fileName:(NSString *)fileName
{
    NSString *directory = [[self pathDocumentDirectory] stringByAppendingPathComponent:folder];
    NSString *filePath = [directory stringByAppendingPathComponent:fileName];
    return filePath;
}

#pragma 文件操作
/**
 创建文件夹
 
 @param folder 文件夹名
 */
+ (BOOL)createFileDirectoryWithFolder:(NSString *)folder
{
    NSString *directory = [[self pathDocumentDirectory] stringByAppendingPathComponent:folder];
    BOOL result = [[NSFileManager defaultManager] createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
    return result;
}

/**
 创建文件
 
 @param folder 文件夹
 @param fileName 文件
 */
+ (BOOL)createFileWithFolder:(NSString *)folder fileName:(NSString *)fileName
{
    [self createFileDirectoryWithFolder:folder];
    NSString *filePath = [self pathDocumentDirectoryWithFolder:folder fileName:fileName];
    BOOL result = [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    return result;
}

/**
 写入文件
 
 @param folder  文件夹
 @param fileName 文件
 @param data 数据
 */
+ (NSString *)writeFileWithFolder:(NSString *)folder fileName:(NSString *)fileName data:(NSData *)data
{
    [self createFileWithFolder:folder fileName:fileName];
    NSString *filePath = [self pathDocumentDirectoryWithFolder:folder fileName:fileName];
    BOOL result = [data writeToFile:filePath atomically:YES];
    return result ? filePath : nil;
}


/**
 读取文件
 
 @param folder 文件夹
 @param fileName 文件
 
 NSLog(@"图片读取成功: %@",[UIImage imageWithData:data]);
 NSLog(@"文件读取成功: %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
 */
+ (NSData *)readFileWithFolder:(NSString *)folder fileName:(NSString *)fileName
{
    NSString *filePath = [self pathDocumentDirectoryWithFolder:folder fileName:fileName];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    return data;
}

/**
 删除文件
 
 @param folder 文件夹
 @param fileName 文件
 */
+ (BOOL)deleteFileWithFolder:(NSString *)folder fileName:(NSString *)fileName
{
    NSString *filePath = [self pathDocumentDirectoryWithFolder:folder fileName:fileName];
    BOOL result = [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    return result;
}

#pragma mark - 文件判断
/**
 文件是否存在
 
 @param folder 文件夹
 @param fileName 文件
 */
+ (BOOL)isExecutableFileWithFolder:(NSString *)folder fileName:(NSString *)fileName
{
    NSString *filePath = [self pathDocumentDirectoryWithFolder:folder fileName:fileName];
    BOOL result = [[NSFileManager defaultManager] isExecutableFileAtPath:filePath];
    return result;
}

/**
 文件属性
 
 @param folder 文件夹
 @param fileName 文件
 */
+ (void)typeFileWithFolder:(NSString *)folder fileName:(NSString *)fileName
{
    NSString *filePath = [self pathDocumentDirectoryWithFolder:folder fileName:fileName];
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
    NSArray *keys;
    id key, value;
    keys = [fileAttributes allKeys];
    NSInteger count = [keys count];
    for (int i = 0; i < count; i++){
        key = [keys objectAtIndex: i];
        value = [fileAttributes objectForKey: key];
        NSLog (@"Key: %@ Value: %@", key, value);
    }
}
@end
