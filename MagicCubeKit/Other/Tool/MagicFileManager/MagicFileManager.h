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
+ (NSString *)pathDocumentDirectoryWithFolder:(NSString *)folder
                                     fileName:(NSString *)fileName;

+ (BOOL)createFileDirectoryWithFolder:(NSString *)folder;
+ (BOOL)createFileWithFolder:(NSString *)folder
                    fileName:(NSString *)fileName;

+ (NSString *)writeFileWithFolder:(NSString *)folder
                         fileName:(NSString *)fileName
                             data:(NSData *)data;

+ (NSData *)readFileWithFolder:(NSString *)folder
                      fileName:(NSString *)fileName;

+ (BOOL)deleteFileWithFolder:(NSString *)folder
                    fileName:(NSString *)fileName;

+ (BOOL)isExecutableFileWithFolder:(NSString *)folder
                          fileName:(NSString *)fileName;

+ (void)typeFileWithFolder:(NSString *)folder
                  fileName:(NSString *)fileName;
@end
