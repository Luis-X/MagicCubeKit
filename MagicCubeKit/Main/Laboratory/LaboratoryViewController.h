//
//  LaboratoryViewController.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/27.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "BaseViewController.h"
#import "QDNavigationController.h"
#import "MCAlbumViewController.h"
#import "MCImagePickerViewController.h"
#import "MCMultipleImagePickerPreviewViewController.h"

@interface LaboratoryViewController : BaseViewController<QMUIAlbumViewControllerDelegate, QMUIImagePickerViewControllerDelegate, MCMultipleImagePickerPreviewViewControllerDelegate>

@end
