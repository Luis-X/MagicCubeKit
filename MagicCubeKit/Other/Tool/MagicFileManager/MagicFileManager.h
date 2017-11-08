//
//  MagicFileManager.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/7/27.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MagicFileManager : NSObject
+ (NSString *)pathHomeDirectory;
+ (NSString *)pathDocumentDirectory;
+ (NSString *)pathLibraryDirectory;
+ (NSString *)pathCachesDirectory;
+ (NSString *)pathTemporaryDirectory;
+ (NSString *)pathDocumentDirectoryWithFolder:(NSString *)folder file:(NSString *)file;

+ (BOOL)createFileDirectoryWithFolder:(NSString *)folder;
+ (BOOL)createFileWithFolder:(NSString *)folder file:(NSString *)file;
+ (BOOL)writeFileWithFolder:(NSString *)folder file:(NSString *)file content:(NSString *)content;
+ (NSData *)readFileWithFolder:(NSString *)folder file:(NSString *)file;
+ (BOOL)deleteFileWithFolder:(NSString *)folder file:(NSString *)file;
+ (BOOL)isExecutableFileWithFolder:(NSString *)folder file:(NSString *)file;
+ (void)typeFileWithFolder:(NSString *)folder file:(NSString *)file;
@end
