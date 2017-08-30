//
//  ExampleMagicNetworkingViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/17.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ExampleMagicNetworkingViewController.h"

@interface ExampleMagicNetworkingViewController ()

@end

@implementation ExampleMagicNetworkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mainTitle = @"MagicNetworkManager";
    [self createMainView];
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

- (void)createMainView{
    
    [[MagicNetworkManager shareManager] GET:@"http://mi.xcar.com.cn/interface/xcarapp/getBrands.php" Parameters:nil Success:^(NSURLResponse *response, id responseObject) {
        //NSLog(@"%@", responseObject);
    } Failure:^(NSURLResponse *response, id error) {
        NSLog(@"%@", error);
    }];
    
}

@end
