//
//  ProductSelectQuantityView.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/6/7.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ProductSelectQuantityView.h"

@interface ProductSelectQuantityView ()<UITextFieldDelegate>

@end

@implementation ProductSelectQuantityView{
    UILabel *_cutButton;            //减少
    UILabel *_addButton;            //增加
    UITextField *_numTextField;     //数量
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialData];
        [self createSubViews];
        [self settingAutoLayout];
        [self checkAndUpdateCurrentNum];
    }
    return self;
}

#pragma mark -Property
- (void)setCurrentNum:(NSInteger)currentNum{
    _currentNum = currentNum;
    [self checkAndUpdateCurrentNum];
}

- (void)setMiniValue:(NSInteger)miniValue{
    _miniValue = miniValue;
    [self checkAndUpdateCurrentNum];
}

- (void)setMaxValue:(NSInteger)maxValue{
    _maxValue = maxValue;
    [self checkAndUpdateCurrentNum];
}

- (void)setInputEnabled:(BOOL)inputEnabled{
    _inputEnabled = inputEnabled;
    _numTextField.enabled = inputEnabled;
}


- (void)initialData{
    
    _currentNum = 1;
    _miniValue = 1;
    _maxValue = MAXFLOAT;
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 4;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor blackColor].CGColor;
    
}

- (void)createSubViews{
    
    _cutButton = [UILabel new];
    _cutButton.font = [UIFont fontWithName:@"iconfont" size:15];
    _cutButton.text = @"\U0000e625";
    _cutButton.textAlignment = NSTextAlignmentCenter;
    _cutButton.userInteractionEnabled = YES;
    [self addSubview:_cutButton];
    [_cutButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cutButtonAction)]];

    
    _addButton = [UILabel new];
    _addButton.font = [UIFont fontWithName:@"iconfont" size:15];
    _addButton.text = @"\U0000e624";
    _addButton.textAlignment = NSTextAlignmentCenter;
    _addButton.userInteractionEnabled = YES;
    [self addSubview:_addButton];
    [_addButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addButtonAction)]];
    
    
    _numTextField = [UITextField new];
    _numTextField.layer.borderWidth = 0.5;
    _numTextField.layer.borderColor = [UIColor blackColor].CGColor;
    _numTextField.keyboardType = UIKeyboardTypeNumberPad;
    _numTextField.textAlignment = NSTextAlignmentCenter;
    _numTextField.enabled = NO;
    _numTextField.delegate = self;
    [self addSubview:_numTextField];
    
}

- (void)settingAutoLayout{
    
    [_cutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.equalTo(self.mas_height);
    }];
    
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self);
        make.width.equalTo(self.mas_height);
    }];
    
    [_numTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(_cutButton.mas_right);
        make.right.equalTo(_addButton.mas_left);
    }];
    
}

#pragma mark -Action

- (void)cutButtonAction{
    _currentNum--;
    [self checkAndUpdateCurrentNum];
}

- (void)addButtonAction{
    _currentNum++;
    [self checkAndUpdateCurrentNum];
}

#pragma mark -Update
/*
 * 检查更新数量
 */
- (void)checkAndUpdateCurrentNum{
    
    //最小限制
    if (_currentNum <= _miniValue) {
        _currentNum = _miniValue;
        _cutButton.textColor = [UIColor grayColor];
    }else{
         _cutButton.textColor = [UIColor blackColor];
    }
    
    //最大限制
    if (_currentNum >= _maxValue) {
        _currentNum = _maxValue;
        _addButton.textColor = [UIColor grayColor];
    }else{
         _addButton.textColor = [UIColor blackColor];
    }
    
    _numTextField.text = [NSString stringWithFormat:@"%ld", _currentNum];
    
}

#pragma mark -UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString *text = nil;
    //如果string为空，表示删除
    if (string.length > 0) {
        text = [NSString stringWithFormat:@"%@%@",textField.text,string];
    }else{
        text = [textField.text substringToIndex:range.location];
    }
    
    //最大值
    _currentNum = [text integerValue];
    if (_currentNum >= _maxValue) {
        [self checkAndUpdateCurrentNum];
        return NO;
    }
    
    return YES;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    _currentNum = [textField.text integerValue];
    [self checkAndUpdateCurrentNum];
}

#pragma mark -隐藏键盘
- (void)hiddenKeyboard{
    [_numTextField resignFirstResponder];
}

@end
