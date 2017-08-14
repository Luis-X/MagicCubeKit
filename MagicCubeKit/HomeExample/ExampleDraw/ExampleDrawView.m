//
//  ExampleDrawView.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/14.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ExampleDrawView.h"

@implementation ExampleDrawView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //1.获取一个绘图区域
    CGContextRef context = UIGraphicsGetCurrentContext();
    //2.保存现有绘图区域状态
    CGContextSaveGState(context);
    //3.设置绘图区域坐标, 将(0,0)改为左下角
    CGAffineTransform t = CGContextGetCTM(context);
    t = CGAffineTransformInvert(t);
    CGContextConcatCTM(context, t);
    
    //4.开始绘图
    CGContextSetLineWidth(context, 15);                     //线宽
    CGContextSetRGBStrokeColor(context, 0, 0, 1, 1);        //颜色
    //实线
    CGContextMoveToPoint(context, 10, 100);                 //开始点
    CGContextAddLineToPoint(context, 200, 100);             //直线结束点
    CGContextDrawPath(context, kCGPathStroke);
    //虚线
    CGFloat dashes[] = {10 , 10};
    CGContextSetLineDash(context, 0, dashes, sizeof(dashes) / sizeof(CGFloat));
    CGContextMoveToPoint(context, 10, 150);
    CGContextAddLineToPoint(context, 200, 150);
    CGContextDrawPath(context, kCGPathStroke);
    //花虚线
    CGFloat dashes2[] = {6, 6, 2, 3};
    CGContextSetLineDash(context, 0, dashes2, sizeof(dashes2) / sizeof(CGFloat));
    CGContextMoveToPoint(context, 10, 200);
    CGContextAddLineToPoint(context, 200, 200);
    CGContextDrawPath(context, kCGPathStroke);
    
    //5.还原绘图区域状态
    CGContextRestoreGState(context);
    
}

@end
