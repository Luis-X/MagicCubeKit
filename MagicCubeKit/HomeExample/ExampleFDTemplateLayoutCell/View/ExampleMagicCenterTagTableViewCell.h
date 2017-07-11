//
//  ExampleMagicCenterTagTableViewCell.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/7/6.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExampleMagicCenterTagTableViewCell : UITableViewCell<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)NSArray *allTagsArray;
@end
