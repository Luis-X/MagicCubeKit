//
//  MagicActivityCollectionViewCell.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/17.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MagicActivity.h"

@protocol MagicActivityCollectionViewCellDelegate <NSObject>

- (void)magicActivityCollectionViewCellDidSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface MagicActivityCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong)MagicActivity *magicActivityItem;
@property (nonatomic, weak) id <MagicActivityCollectionViewCellDelegate>delegate;
@property (nonatomic, strong) NSIndexPath *cellIndexPath;
@end
