//
//  AutoAlbumViewController.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/7/21.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoAlbumViewController : UIViewController
- (void)networkGetAutoAlbumDataWithKey:(NSString *)key backgroundImage:(UIImage *)backgroundImage;
@end
