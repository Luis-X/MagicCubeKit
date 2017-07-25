//
//  MagicImagePicker.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/7/13.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^MagicImagePickerBlockSuccess)(BOOL success);  //成功Block

@protocol MagicImagePickerDelegate <NSObject>
- (void)magicSystemImagePickerDidFinishPickingMediaWithImage:(UIImage *)image;
- (void)magicSystemImagePickerDidCancel;
@end


@interface MagicImagePicker : NSObject
+ (MagicImagePicker *)shareManager;
- (void)showImagePickerWithTitle:(NSString *)title message:(NSString *)message addController:(UIViewController *)addController delegate:(id)delegate;
- (void)saveToSystemPhotosAlbum:(NSArray *)images completion:(MagicImagePickerBlockSuccess)completion;
@end
