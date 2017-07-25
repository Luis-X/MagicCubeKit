//
//  AutoAlbumViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/7/21.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "AutoAlbumViewController.h"
#import "MagicNetworkManager.h"
#import "AlbumModel.h"
#import <NYTPhotoViewer.h>
#import "NYTExamplePhoto.h"
#import "AutoAlbumCollectionViewCell.h"
#import "MagicImagePicker.h"

@interface AutoAlbumViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation AutoAlbumViewController{
    UICollectionView *_mainCollectionView;
    NSMutableArray *_allImageViewArray;
    NSMutableArray *_allImageArray;
    NSMutableArray *_saveImageArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initialData];
    [self createSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)initialData{
    _allImageViewArray = [NSMutableArray array];
    _allImageArray = [NSMutableArray array];
}

- (void)networkGetAutoAlbumDataWithKey:(NSString *)key backgroundImage:(UIImage *)backgroundImage{
    
    self.title = key;
    [_allImageViewArray removeAllObjects];
    [_allImageArray removeAllObjects];
    
    [QuicklyHUD showWindowsProgressHUDText:@"正在生成"];
    [[MagicNetworkManager shareManager] GET:@"https://shop.m.showjoy.com/shop/foreshow/get" Parameters:nil Success:^(NSURLResponse *response, id responseObject) {
        
        //解析
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            [self buildRowDataWithData:dataDic Key:key backgroundImage:backgroundImage];
            
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self getAllAutoAlbumImagesWithImageViewArray:_allImageViewArray];
            [_mainCollectionView reloadData];
            [QuicklyHUD hiddenMBProgressHUDForView:[UIApplication sharedApplication].keyWindow];
        });
        
    } Failure:^(NSURLResponse *response, id error) {
        [QuicklyHUD showWindowsOnlyTextHUDText:@"网络请求失败"];
        
    }];

}

//分组数据
- (void)buildRowDataWithData:(NSDictionary *)data Key:(NSString *)key backgroundImage:(UIImage *)backgroundImage{
   
    NSArray *array = [data objectForKey:key];
    for (NSDictionary *dic in array) {
        // 整点
        if ([key isEqualToString:@"整点×抢购"]) {
            NSArray *itemArray = [dic objectForKey:@"data"];
            for (NSDictionary *itemDic in itemArray) {
                AlbumModel *model = [AlbumModel new];
                [model setValuesForKeysWithDictionary:itemDic];
                model.time = [NSString stringWithFormat:@"%@", [dic objectForKey:@"time"]];
                //创建视图
                UIImageView *photoImageView = [self createMainViewWithAlbumItemModel:model
                                                                     backgroundImage:backgroundImage];
                if (photoImageView) {
                    [_allImageViewArray addObject:photoImageView];
                }
            }
        }else{
        // 普通
            AlbumModel *model = [AlbumModel new];
            [model setValuesForKeysWithDictionary:dic];
            //创建视图
            UIImageView *photoImageView = [self createMainViewWithAlbumItemModel:model
                                                                 backgroundImage:backgroundImage];
            if (photoImageView) {
                [_allImageViewArray addObject:photoImageView];
            }
        }
    }
    
}

- (void)createSubViews{
    
    [self createMainCollectionView];
    
}

- (void)createMainCollectionView{
    
    //一键保存
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.backgroundColor = [UIColor colorWithRed:0.96 green:0.22 blue:0.33 alpha:1.00];
    [saveButton setTitle:@"一键保存" forState:UIControlStateNormal];
    [self.view addSubview:saveButton];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.bottom.left.right.equalTo(self.view);
    }];
    [saveButton addTarget:self action:@selector(saveButtonAction) forControlEvents:UIControlEventTouchUpInside];

    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    layout.itemSize = [self getItemSizeCollectionWidth:Screen_width Num:3 Space:5];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _mainCollectionView.backgroundColor = [UIColor colorWithWhite:0.00 alpha:0.80];
    _mainCollectionView.dataSource = self;
    _mainCollectionView.delegate = self;
    [self.view addSubview:_mainCollectionView];
    [_mainCollectionView registerClass:[AutoAlbumCollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    [_mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(saveButton.mas_top);
    }];
    
}

#pragma mark -UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _allImageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AutoAlbumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    [cell updateCellDataWithValue:[_allImageArray objectAtIndex:indexPath.row]];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self showPhotosViewControllerWithIndex:indexPath.row];
}



- (UIImageView *)createMainViewWithAlbumItemModel:(AlbumModel *)albumItemModel backgroundImage:(UIImage *)backgroundImage{
    
    UIImageView *backgroudImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, Screen_height, 375, 667)];
    backgroudImageView.contentMode = 2;
    backgroudImageView.clipsToBounds = YES;
    [backgroudImageView setImage:backgroundImage];
    [self.view addSubview:backgroudImageView];

    
    UILabel *titleLabel = [UILabel new];
    titleLabel.numberOfLines = 2;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor colorWithRed:0.10 green:0.07 blue:0.06 alpha:1.00];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [backgroudImageView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroudImageView).offset(96);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(50);
        make.centerX.equalTo(backgroudImageView);
    }];
    
    UIImageView *imageView = [UIImageView new];
    [backgroudImageView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.size.mas_offset(CGSizeMake(300, 300));
        make.centerX.equalTo(backgroudImageView);
    }];
    
    UILabel *priceLabel = [UILabel new];
    [backgroudImageView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(5);
        make.centerX.equalTo(backgroudImageView);
    }];
    
    UILabel *originalPriceLabel = [UILabel new];
    originalPriceLabel.textColor = [UIColor colorWithRed:0.96 green:0.22 blue:0.33 alpha:1.00];
    originalPriceLabel.font = [UIFont systemFontOfSize:12];
    [backgroudImageView addSubview:originalPriceLabel];
    [originalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(priceLabel.mas_bottom).offset(5);
        make.centerX.equalTo(backgroudImageView);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor colorWithRed:0.96 green:0.24 blue:0.35 alpha:1.00];
    [backgroudImageView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(originalPriceLabel);
        make.left.equalTo(originalPriceLabel);
        make.right.equalTo(originalPriceLabel);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *dateLabel = [UILabel new];
    dateLabel.textColor = [UIColor whiteColor];
    dateLabel.font = [UIFont boldSystemFontOfSize:14];
    [backgroudImageView addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(backgroudImageView).offset(-88);
        make.centerX.equalTo(backgroudImageView);
    }];
    
    //赋值
    titleLabel.text = [NSString stringWithFormat:@"%@", albumItemModel.title];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[self checkValidityWithUrl:albumItemModel.image]]];
    priceLabel.text = [NSString stringWithFormat:@"¥%.2f", [albumItemModel.price floatValue]];
    originalPriceLabel.text =[NSString stringWithFormat:@"市场价：¥%.2f", [albumItemModel.orginPrice floatValue]];
    if (albumItemModel.time) {
        dateLabel.text = [NSString stringWithFormat:@"%@", albumItemModel.time];
    }
    [self setRichNumberWithLabel:priceLabel BigSize:50 SmallSize:20 Color:[UIColor colorWithRed:0.96 green:0.22 blue:0.33 alpha:1.00]];
    
    return backgroudImageView;
}


/**
 *  保存图片
 */
- (void)saveButtonAction{
    
    if (_allImageArray.count <= 0) {
        [QuicklyHUD showWindowsOnlyTextHUDText:@"暂无图片"];
        return;
    }

    [QuicklyHUD showWindowsProgressHUDText:@"保存中..."];
    _saveImageArray = [NSMutableArray arrayWithArray:_allImageArray];
    [self saveNext];

}

#pragma mark - 生成图片
- (void)getAllAutoAlbumImagesWithImageViewArray:(NSArray *)imageViewArray{
    
    for (UIImageView *imageView in imageViewArray) {
        UIImage *image = [self getscreenShotsResultImageWithView:imageView];
        if (image) {
            [_allImageArray addObject:image];
        }
    }
    
}

- (UIImage *)getscreenShotsResultImageWithView:(UIView *)view{
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size,YES, 0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

#pragma mark - 保存相册回调
- (void)saveNext{

    [[MagicImagePicker shareManager] saveToSystemPhotosAlbum:_saveImageArray completion:^(BOOL success) {
        [QuicklyHUD showWindowsOnlyTextHUDText:@"保存成功"];
    }];
    
}

#pragma mark - 图片浏览
- (void)showPhotosViewControllerWithIndex:(NSInteger)index{
    
    NSMutableArray *photos = [NSMutableArray array];
    for (UIImage *resultImage in _allImageArray) {
        NYTExamplePhoto *resultPhoto = [NYTExamplePhoto new];
        resultPhoto.image = resultImage;
        if (resultPhoto) {
            [photos addObject:resultPhoto];
        }
    }

    NYTPhotosViewController *photosViewController = [[NYTPhotosViewController alloc] initWithPhotos:photos initialPhoto:[photos objectAtIndex:index]];
    [self presentViewController:photosViewController animated:YES completion:nil];
    
}

#pragma mark - 样式
- (void)setRichNumberWithLabel:(UILabel*)label BigSize:(CGFloat)bigSize SmallSize:(CGFloat)smallSize Color:(UIColor *)color{
    
    if (label.text == nil) {
        //NSLog(@"过滤空数据");
        return;
    }
    
    NSArray *aimArray = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"];      //生效字符
    NSString *flagString = @".";                                                            //分割标识
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:label.text];
    NSString *temp = nil;
    for(int i = 0; i < [attributedString length]; i++){
        
        temp = [label.text substringWithRange:NSMakeRange(i, 1)];
        
        for (NSString *aimString in aimArray) {
            if([temp isEqualToString:aimString]){
                [attributedString setAttributes:@{NSForegroundColorAttributeName:color, NSFontAttributeName:[UIFont boldSystemFontOfSize:bigSize]} range:NSMakeRange(i, 1)];
            }
        }
        
        if([temp isEqualToString:@"¥"] || [temp isEqualToString:flagString]){
            [attributedString setAttributes:@{NSForegroundColorAttributeName:color, NSFontAttributeName:[UIFont boldSystemFontOfSize:smallSize]} range:NSMakeRange(i, 1)];
        }
        
        if ([temp isEqualToString:flagString]) {
            [attributedString setAttributes:@{NSForegroundColorAttributeName:color, NSFontAttributeName:[UIFont boldSystemFontOfSize:smallSize]} range:NSMakeRange(i, (attributedString.length - i))];
            break;
        }
        
    }
    
    label.attributedText = attributedString;
    
}


- (CGSize)getItemSizeCollectionWidth:(CGFloat)collectionWidth Num:(NSInteger)num Space:(CGFloat)space{
    
    if (num <= 0) {
        return CGSizeZero;
    }
    double itemWidth = (collectionWidth - ((num + 1) * space)) / num;
    return CGSizeMake(itemWidth, itemWidth);
    
}

- (NSString *)checkValidityWithUrl:(NSString *)url{
    
    NSString *result = url;
    //双斜杠
    if ([result hasPrefix:@"//"]) {
        result = [NSString stringWithFormat:@"https:%@", result];
    }
    
    //绝对路径
    if ([result containsString:@"http://"]) {
        result = [result stringByReplacingOccurrencesOfString:@"http://" withString:@"https://"];
    }
    return result;
    
}

@end
