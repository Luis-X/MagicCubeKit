//
//  main.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/4/28.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

//整个APP程序的主函数,入口函数
int main(int argc, char * argv[]) {
    
    //自动内存释放池
    @autoreleasepool {
        //UIKit框架结构的启动函数
        //参数1:  argc    启动时带有参数的个数
        //参数2:  argv    参数列表
        //参数3:  nil     要求传入一个主框架类类名,如果参数为nil系统会用默认的框架类作为主框架类名
        //参数4:  主框架的代理类对象名字
#pragma mark -UIApplicationMain()函数内部启动了一个RunLoop,所以UIApplicationMain()函数一直没有返回,保持了程序的持续运行
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
