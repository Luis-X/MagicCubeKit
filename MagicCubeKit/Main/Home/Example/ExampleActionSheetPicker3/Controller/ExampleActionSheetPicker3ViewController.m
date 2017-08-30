//
//  ExampleActionSheetPicker3ViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/17.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ExampleActionSheetPicker3ViewController.h"
#import <ActionSheetPicker.h>
@interface ExampleActionSheetPicker3ViewController ()<ActionSheetCustomPickerDelegate>

@end

@implementation ExampleActionSheetPicker3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (void)baseBuildSubViews{
    
}


/**
 日期
 */
- (void)showDatePickerView{
    [ActionSheetDatePicker showPickerWithTitle:@"标题"
                                datePickerMode:UIDatePickerModeDate
                                  selectedDate:[NSDate date]
                                   minimumDate:[NSDate dateWithTimeIntervalSinceNow:-30 * 24 * 3600]
                                   maximumDate:[NSDate dateWithTimeIntervalSinceNow:30 * 24 * 3600]
                                     doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
                                         
                                         NSLog(@"%@",selectedDate);
                                         
                                     } cancelBlock:^(ActionSheetDatePicker *picker) {
                                         NSLog(@"cancel");
                                         
                                     } origin:self.view];
}

/**
 内容
 */
- (void)showStringPickerView{
    [ActionSheetStringPicker showPickerWithTitle:@"title"
                                            rows:@[@"0",@"1",@"2",@"3",@"4"]
                                initialSelection:2
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           
                                           NSLog(@"%ld - %@",(long)selectedIndex, selectedValue);
                                           
                                       } cancelBlock:^(ActionSheetStringPicker *picker) {
                                           
                                           NSLog(@"cancel");
                                           
                                       } origin:self.view];
}


/**
 多重
 */
- (void)showMultipleStringPickerView{
    NSArray *section1 = @[@"0",@"1",@"2",@"3",@"4"];
    NSArray *section2 = @[@"0",@"1",@"2",@"3",@"4"];
    
    NSArray *sectionData = @[section1,section2];
    NSArray *selectIndex = @[@1,@2];
    
    [ActionSheetMultipleStringPicker showPickerWithTitle:@"title"
                                                    rows:sectionData
                                        initialSelection:selectIndex
                                               doneBlock:^(ActionSheetMultipleStringPicker *picker, NSArray *selectedIndexes, id selectedValues) {
                                                   
                                                   NSLog(@"%@",selectedValues);
                                                   
                                               } cancelBlock:^(ActionSheetMultipleStringPicker *picker) {
                                                   
                                               } origin:self.view];
}


/**
 自定义
 */
- (void)showCustomPickerView{
    [ActionSheetCustomPicker showPickerWithTitle:@"title"
                                        delegate:self
                                showCancelButton:YES
                                          origin:self.view];
}

#pragma mark - ActionSheetCustomPicker Delegate

- (void)actionSheetPicker:(AbstractActionSheetPicker *)actionSheetPicker configurePickerView:(UIPickerView *)pickerView{
    pickerView.delegate = self;
}

- (void)actionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin{
    NSLog(@"success");
}

- (void)actionSheetPickerDidCancel:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin{
    NSLog(@"cancel");
}

#pragma mark - PickView Delegete
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 10;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return @"test";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"%ld - %ld",component, row);
}

@end
