//
//  ExampleElementImage.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/2.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ExampleElementImage.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ExampleElementImage()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ExampleElementImage

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.userInteractionEnabled = NO;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [self addSubview:_imageView];
        self.backgroundColor = [UIColor grayColor];
    }
    return _imageView;
}

- (UILabel *)titleLabel{
    if (nil == _titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor redColor];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(void)setImgUrl:(NSString *)imgUrl{
    
    if (imgUrl.length > 0) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
    }
    
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    if (frame.size.width > 0 && frame.size.height > 0) {
        [self mui_afterGetView];
    }
}

- (void)mui_afterGetView{
    
    self.imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.titleLabel.text = [NSString stringWithFormat:@"%ld",[self.number longValue]];
    [self.titleLabel sizeToFit];
    
}


+ (CGFloat)heightByModel:(TangramDefaultItemModel *)itemModel{
    
    return 100.f;
    
}

@end
