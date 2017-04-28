//
//  ViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/4/28.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    UITextView *_mainTextView;
}


/**
 *  ViewController声明周期
 
 一、     viewDidLoad             第一次程序加载视图(只加载一次)
 二、     viewWillAppear          视图即将显示(每次显示都会调用)
 三、     viewDidAppear           视图已经显示
 四、     viewWillDisappear       视图即将消失
 五、     viewDidDisappear        视图已经消失
 
 */

- (instancetype)init{
    
    self = [super init];
    if (self) {
        [self createMainView];
        NSString *showString = @"init   初始化！";
        NSLog(@"%@", showString);
        [self updateMainTextViewString:showString];
    }
    return self;
    
}

/**
 *
 *  加载视图资源并初始化视图
 *
 */
- (void)loadView{
    
    [super loadView];
    NSString *showString = @"loadView   视图加载！";
    NSLog(@"%@", showString);
    [self updateMainTextViewString:showString];
    
}

/**
 *  一、第一次程序加载视图
 *
 *  只加载一次
 *  用途: 布局初始化视图,初始化资源
 */
- (void)viewDidLoad {
    
    //调用父类加载视图函数
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *showString = @"viewDidLoad   第一次程序加载视图！";
    NSLog(@"%@", showString);
    [self updateMainTextViewString:showString];
    
}

/**
 *  二、视图即将显示
 *
 *  每一次视图显示都会被调用
 */
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    NSString *showString = @"viewWillAppear   视图即将显示！";
    NSLog(@"%@", showString);
    [self updateMainTextViewString:showString];
    
}

/**
 *  三、视图已经显示
 *
 *
 */
- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    NSString *showString = @"viewDidAppear   视图已经显示！";
    NSLog(@"%@", showString);
    [self updateMainTextViewString:showString];
    
}

/**
 *  四、视图即将消失
 *
 *
 */
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    NSString *showString = @"viewWillDisappear   视图即将消失！";
    NSLog(@"%@", showString);
    [self updateMainTextViewString:showString];
    
}


/**
 *  五、视图已经消失
 *
 *
 */
- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    NSString *showString = @"viewDidDisappear   视图已经消失！";
    NSLog(@"%@", showString);
    [self updateMainTextViewString:showString];
    
}




/**
 *  当系统内存过低时,会发起警告信息
 *  用途: 进行内存释放操作
 */
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSString *showString = @"内存过低模拟: HardWare->Simulate Memory Warning";
    NSLog(@"%@", showString);
    [self updateMainTextViewString:showString];
    
}




//屏幕被点击时调用
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSString *showString = @"屏幕被点击";
    NSLog(@"%@", showString);
    [self updateMainTextViewString:showString];
    
}


#pragma mark - 视图
- (void)createMainView{
    
    _mainTextView = [UITextView new];
    _mainTextView.text = @"";
    _mainTextView.editable = NO;
    _mainTextView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_mainTextView];
    [_mainTextView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.left.right.equalTo(self.view);
        make.height.mas_equalTo(Magic_Screen_height / 2);
        
    }];
    
}

- (void)updateMainTextViewString:(NSString *)string{
    _mainTextView.text = [_mainTextView.text stringByAppendingString:[NSString stringWithFormat:@"\n\n%@", string]];
}
@end
