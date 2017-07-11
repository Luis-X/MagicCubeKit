//
//  ExampleMagicCenterTagTableViewCell.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/7/6.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ExampleMagicCenterTagTableViewCell.h"
#import "EqualSpaceFlowLayoutEvolve.h"
#import "ProductConstant.h"
#import "ExampleMagicCenterTagCollectionViewCell.h"

@implementation ExampleMagicCenterTagTableViewCell{
    UICollectionView *_mainCollectionView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews{
    
    EqualSpaceFlowLayoutEvolve *layout = [[EqualSpaceFlowLayoutEvolve alloc] initWthType:AlignWithCenter];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, Magic_screen_Width, 0) collectionViewLayout:layout];
    _mainCollectionView.backgroundColor = [UIColor whiteColor];
    _mainCollectionView.dataSource = self;
    _mainCollectionView.delegate = self;
    _mainCollectionView.scrollsToTop = NO;
    _mainCollectionView.scrollEnabled = NO;
    [self.contentView addSubview:_mainCollectionView];
    [_mainCollectionView registerClass:[ExampleMagicCenterTagCollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _allTagsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ExampleMagicCenterTagCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    NSString *name = [NSString stringWithFormat:@"%@", [_allTagsArray objectAtIndex:indexPath.row]];
    [cell updateCellDataWithValue:name];
    return cell;
    
}

#pragma mark -UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *name = [NSString stringWithFormat:@"%@", [_allTagsArray objectAtIndex:indexPath.row]];
    CGFloat cell_width = [ProductConstant getTextWidthWithText:name
                                                        height:CenterTagCell_height
                                                          font:[UIFont systemFontOfSize:10 * HOME_IPHONE6_HEIGHT]];
    return CGSizeMake(cell_width + 20 * HOME_IPHONE6_WIDTH, CenterTagCell_height);

    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -更新数据
- (void)setAllTagsArray:(NSArray *)allTagsArray{
    _allTagsArray = allTagsArray;
    [_mainCollectionView reloadData];

    [_mainCollectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.width.mas_equalTo(Magic_screen_Width);
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo([_mainCollectionView.collectionViewLayout collectionViewContentSize].height);
    }];
}
@end
