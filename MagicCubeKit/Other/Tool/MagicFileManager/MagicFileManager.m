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
+ (NSString *)pathHomeDirectory{
    NSString *result = NSHomeDirectory();
    NSLog(@"根路径: %@",result);
    return result;
}

/**
 获取Documents
 */
+ (NSString *)pathDocumentDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *result = [paths objectAtIndex:0];
    NSLog(@"Document路径: %@", result);
    return result;
}

/**
 获取Library
 */
+ (NSString *)pathLibraryDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *result = [paths objectAtIndex:0];
    NSLog(@"Library路径: %@",result);
    return result;
}

/**
 获取Caches
 */
+ (NSString *)pathCachesDirectory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *result = [paths objectAtIndex:0];
    NSLog(@"Caches路径: %@",result);
    return result;
}

/**
 获取Temporary
 */
+ (NSString *)pathTemporaryDirectory{
    NSString *result = NSTemporaryDirectory();
    NSLog(@"Temporary路径: %@",result);
    return result;
}

/**
 获取文件路径
 */
+ (NSString *)pathDocumentDirectoryWithFolder:(NSString *)folder file:(NSString *)file{
    NSString *directory = [[self pathDocumentDirectory] stringByAppendingPathComponent:folder];
    NSString *filePath = [directory stringByAppendingPathComponent:file];
    NSLog(@"文件路径: %@",filePath);
    return filePath;
}

#pragma 文件操作
/**
 创建文件夹

 @param folder 文件夹名
 */
+ (BOOL)createFileDirectoryWithFolder:(NSString *)folder{
    NSString *directory = [[self pathDocumentDirectory] stringByAppendingPathComponent:folder];
    BOOL result = [[NSFileManager defaultManager] createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
    return result;
}

/**
 创建文件
 
 @param folder 文件夹
 @param file   文件
 */
+ (BOOL)createFileWithFolder:(NSString *)folder file:(NSString *)file{
    NSString *filePath = [self pathDocumentDirectoryWithFolder:folder file:file];
    BOOL result = [[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil];
    return result;
}

/**
 写入文件

 @param folder  文件夹
 @param file    文件
 @param content 内容
 */
+ (BOOL)writeFileWithFolder:(NSString *)folder file:(NSString *)file content:(NSString *)content{
    NSString *filePath = [self pathDocumentDirectoryWithFolder:folder file:file];
    BOOL result = [content writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    return result;
}


/**
 读取文件

 @param folder 文件夹
 @param file   文件
 */
+ (NSData *)readFileWithFolder:(NSString *)folder file:(NSString *)file{
    NSString *filePath = [self pathDocumentDirectoryWithFolder:folder file:file];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSLog(@"文件读取成功: %@",data);
    //NSLog(@"图片读取成功: %@",[UIImage imageWithData:data]);
    //NSLog(@"文件读取成功: %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    return data;
}

/**
 删除文件

 @param folder 文件夹
 @param file   文件
 */
+ (BOOL)deleteFileWithFolder:(NSString *)folder file:(NSString *)file{
    NSString *filePath = [self pathDocumentDirectoryWithFolder:folder file:file];
    BOOL result = [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    return result;
}

#pragma mark - 文件判断
/**
 文件是否存在

 @param folder 文件夹
 @param file   文件
 */
+ (BOOL)isExecutableFileWithFolder:(NSString *)folder file:(NSString *)file{
    NSString *filePath = [self pathDocumentDirectoryWithFolder:folder file:file];
    BOOL result = [[NSFileManager defaultManager] isExecutableFileAtPath:filePath];
    return result;
}

/**
 文件属性
 
 @param folder 文件夹
 @param file   文件
 */
+ (void)typeFileWithFolder:(NSString *)folder file:(NSString *)file{
    NSString *filePath = [self pathDocumentDirectoryWithFolder:folder file:file];
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
