//
//  ExampleXLFormViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/8/14.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ExampleXLFormViewController.h"

@interface ExampleXLFormViewController ()

@end

@implementation ExampleXLFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    XLFormDescriptor * form;
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;
    
    form = [XLFormDescriptor formDescriptorWithTitle:@"Add Event"];
#pragma mark -文本输入
    //分组(1)
    section = [XLFormSectionDescriptor formSection];
    section.title = @"文本输入";
    section.footerTitle = @"文本输入footer";
    [form addFormSection:section];
    
    //Text
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Text" rowType:XLFormRowDescriptorTypeText];
    [row.cellConfigAtConfigure setObject:@"Text" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    //Name
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Name" rowType:XLFormRowDescriptorTypeName];
    [row.cellConfigAtConfigure setObject:@"Name" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    //URL
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"URL" rowType:XLFormRowDescriptorTypeURL];
    [row.cellConfigAtConfigure setObject:@"URL" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    //Email
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Email" rowType:XLFormRowDescriptorTypeEmail];
    [row.cellConfigAtConfigure setObject:@"Email" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    //Password
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Password" rowType:XLFormRowDescriptorTypePassword];
    [row.cellConfigAtConfigure setObject:@"Password" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    //Number
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Number" rowType:XLFormRowDescriptorTypeNumber];
    [row.cellConfigAtConfigure setObject:@"Number" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    //Phone
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Phone" rowType:XLFormRowDescriptorTypePhone];
    [row.cellConfigAtConfigure setObject:@"Phone" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    //Twitter
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Twitter" rowType:XLFormRowDescriptorTypeTwitter];
    [row.cellConfigAtConfigure setObject:@"Twitter" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    //Account
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Account" rowType:XLFormRowDescriptorTypeAccount];
    [row.cellConfigAtConfigure setObject:@"Account" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    //Integer
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Integer" rowType:XLFormRowDescriptorTypeInteger];
    [row.cellConfigAtConfigure setObject:@"Integer" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    
    //Decimal
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Decimal" rowType:XLFormRowDescriptorTypeDecimal];
    [row.cellConfigAtConfigure setObject:@"Decimal" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    //TextView
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"TextView" rowType:XLFormRowDescriptorTypeTextView];
    [section addFormRow:row];
    
#pragma mark -选择视图
    //分组(2)
    section = [XLFormSectionDescriptor formSection];
    section.title = @"选择视图";
    section.footerTitle = @"选择视图footer";
    [form addFormSection:section];
    
    //SelectorPush
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"SelectorPush" rowType:XLFormRowDescriptorTypeSelectorActionSheet title:@"SelectorPush"];
    [section addFormRow:row];
    
    //SelectorAlertView
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"SelectorAlertView" rowType:XLFormRowDescriptorTypeSelectorAlertView title:@"SelectorAlertView"];
    [section addFormRow:row];
    
    //SelectorLeftRight
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"SelectorLeftRight" rowType:XLFormRowDescriptorTypeSelectorLeftRight title:@"SelectorLeftRight"];
    [section addFormRow:row];
    
    //SelectorPickerView
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"SelectorPickerView" rowType:XLFormRowDescriptorTypeSelectorPickerView title:@"SelectorPickerView"];
    [section addFormRow:row];
    
    //SelectorPickerViewInline
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"SelectorPickerViewInline" rowType:XLFormRowDescriptorTypeSelectorPickerViewInline title:@"SelectorPickerViewInline"];
    [section addFormRow:row];
    
    //SelectorSegmentedControl
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"SelectorSegmentedControl" rowType:XLFormRowDescriptorTypeSelectorSegmentedControl title:@"SelectorSegmentedControl"];
    [section addFormRow:row];
    
    //MultipleSelector
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"MultipleSelector" rowType:XLFormRowDescriptorTypeMultipleSelector title:@"MultipleSelector"];
    [section addFormRow:row];
    
#pragma mark -日期/时间
    //分组(3)
    section = [XLFormSectionDescriptor formSection];
    section.title = @"日期/时间";
    section.footerTitle = @"日期/时间footer";
    [form addFormSection:section];
    //DateInline
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"DateInline" rowType:XLFormRowDescriptorTypeDateInline title:@"DateInline"];
    row.value = [NSDate new];
    [section addFormRow:row];
    
    //DateTimeInline
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"DateTimeInline" rowType:XLFormRowDescriptorTypeDateTimeInline title:@"DateTimeInline"];
    row.value = [NSDate new];
    [section addFormRow:row];
    
    //TimeInline
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"TimeInline" rowType:XLFormRowDescriptorTypeTimeInline title:@"TimeInline"];
    row.value = [NSDate new];
    [section addFormRow:row];
    
    //CountDownTimerInline
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"CountDownTimerInline" rowType:XLFormRowDescriptorTypeCountDownTimerInline title:@"CountDownTimerInline"];
    row.value = [NSDate new];
    [section addFormRow:row];
    
    //Date
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Date" rowType:XLFormRowDescriptorTypeDate title:@"Date"];
    row.value = [NSDate new];
    [section addFormRow:row];
    
    //DateTime
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"DateTime" rowType:XLFormRowDescriptorTypeDateTime title:@"DateTime"];
    row.value = [NSDate new];
    [section addFormRow:row];
    
    //Time
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Time" rowType:XLFormRowDescriptorTypeTime title:@"Time"];
    row.value = [NSDate new];
    [section addFormRow:row];
    
    //CountDownTimer
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"CountDownTimer" rowType:XLFormRowDescriptorTypeCountDownTimer title:@"CountDownTimer"];
    row.value = [NSDate new];
    [section addFormRow:row];
    
#pragma mark -布尔
    //分组(4)
    section = [XLFormSectionDescriptor formSection];
    section.title = @"布尔";
    section.footerTitle = @"布尔footer";
    [form addFormSection:section];
    
    //BooleanCheck(勾选)
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"BooleanCheck" rowType:XLFormRowDescriptorTypeBooleanCheck title:@"BooleanCheck"];
    [section addFormRow:row];
    
    //BooleanSwitch(滑块)
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"BooleanSwitch" rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"BooleanSwitch"];
    [section addFormRow:row];
    
#pragma mark -其他
    //分组(5)
    section = [XLFormSectionDescriptor formSection];
    section.title = @"其他";
    section.footerTitle = @"其他footer";
    [form addFormSection:section];
    
    //StepCounter(计数)
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"StepCounter" rowType:XLFormRowDescriptorTypeStepCounter title:@"StepCounter"];
    [section addFormRow:row];
    /*
     //Picker
     row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Picker" rowType:XLFormRowDescriptorTypePicker title:@"Picker"];
     [section addFormRow:row];
     //Slider
     row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Slider" rowType:XLFormRowDescriptorTypeSlider title:@"Slider"];
     [section addFormRow:row];
     //Button
     row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Button" rowType:XLFormRowDescriptorTypeButton title:@"Button"];
     [section addFormRow:row];
     //Info
     row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Info" rowType:XLFormRowDescriptorTypeInfo title:@"Info"];
     [section addFormRow:row];
     //Image
     row = [XLFormRowDescriptor formRowDescriptorWithTag:@"Image" rowType:XLFormRowDescriptorTypeImage title:@"Image"];
     [section addFormRow:row];
     */
    self.form = form;
}

@end
