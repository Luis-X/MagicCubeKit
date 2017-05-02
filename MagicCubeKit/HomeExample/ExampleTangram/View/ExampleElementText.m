//
//  ExampleElementText.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/2.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ExampleElementText.h"

@interface ExampleElementText ()
@property (nonatomic, strong) UILabel *label;
@end


@implementation ExampleElementText

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UILabel *)label{
    if (nil == _label) {
        _label = [[UILabel alloc] init];
        [self addSubview:_label];
    }
    return _label;
}


//提供一个渲染View的时机，生成View后执行
//在View从delegate中返回之后执行，推荐把布局视图等方法放在这个方法内
//如果是在Tangram的组件中使用，在这个方法执行的时候会带frame
- (void)mui_afterGetView{
    
    self.label.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.label.backgroundColor = [UIColor orangeColor];
    self.label.text = self.text;
    
}

//必须实现
//根据itemModel中的数据，返回对应该View的高度
+ (CGFloat)heightByModel:(TangramDefaultItemModel *)itemModel{
    
    return 60.f;
    
}
@end
