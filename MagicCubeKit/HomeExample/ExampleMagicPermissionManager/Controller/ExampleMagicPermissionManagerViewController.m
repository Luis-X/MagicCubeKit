//
//  ExampleMagicPermissionManagerViewController.m
//  MagicCubeKit
//
//  Created by LuisX on 2017/5/10.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import "ExampleMagicPermissionManagerViewController.h"
#import "MagicPermissionManager.h"

@interface ExampleMagicPermissionManagerViewController ()<UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation ExampleMagicPermissionManagerViewController{
    NSArray *_allArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"MagicPermissionManager";
    [self initialData];
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

- (void)initialData{
    _allArray = @[@"相机", @"相册", @"通知", @"网络", @"麦克风", @"定位", @"通讯录", @"日历", @"备忘录"];
}

- (void)createMainView{
    
    UITableView *mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    mainTableView.backgroundColor = [UIColor whiteColor];
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    [mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:mainTableView];
    [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
        
    }];

}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [_allArray objectAtIndex:indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    //相机
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        BOOL open = [[MagicPermissionManager shareManager] iPhoneSystemPermissionCamera];
        if (open) {
            //打开系统相机
            if (TARGET_IPHONE_SIMULATOR) {
                [QuicklyHUD showWindowsOnlyTextHUDText:@"使用相机需要在真机环境哦😆"];
                return;
            }
            [self openSystemUIImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypeCamera];
        }
        
    }
    //相册
    if (indexPath.section == 0 && indexPath.row == 1) {
        
        BOOL open = [[MagicPermissionManager shareManager] iPhoneSystemPermissionPhotoLibrary];
        if (open) {
            //打开系统相册
            [self openSystemUIImagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
        
    }
    //通知
    if (indexPath.section == 0 && indexPath.row == 2) {
        
        BOOL open = [[MagicPermissionManager shareManager] iPhoneSystemPermissionNotification];
        [QuicklyHUD showWindowsOnlyTextHUDText:open ? @"已开启" : @"未开启"];
        
    }
    //网络
    if (indexPath.section == 0 && indexPath.row == 3) {
        
        [[MagicPermissionManager shareManager] iPhoneSystemPermissionNetwork];
        
    }
    //麦克风
    if (indexPath.section == 0 && indexPath.row == 4) {
        
        BOOL open = [[MagicPermissionManager shareManager] iPhoneSystemPermissionAudio];
        [QuicklyHUD showWindowsOnlyTextHUDText:open ? @"已开启" : @"未开启"];
        
    }
    //定位
    if (indexPath.section == 0 && indexPath.row == 5) {
        
        BOOL open = [[MagicPermissionManager shareManager] iPhoneSystemPermissionLocation];
        [QuicklyHUD showWindowsOnlyTextHUDText:open ? @"已开启" : @"未开启"];
        
    }
    //通讯录
    if (indexPath.section == 0 && indexPath.row == 6) {
        
        BOOL open = [[MagicPermissionManager shareManager] iPhoneSystemPermissionAddressBook];
        [QuicklyHUD showWindowsOnlyTextHUDText:open ? @"已开启" : @"未开启"];
        
    }
    //日历
    if (indexPath.section == 0 && indexPath.row == 7) {
        
        BOOL open = [[MagicPermissionManager shareManager] iPhoneSystemPermissionCalendar];
        [QuicklyHUD showWindowsOnlyTextHUDText:open ? @"已开启" : @"未开启"];
        
    }
    //备忘录
    if (indexPath.section == 0 && indexPath.row == 8) {
        
        BOOL open = [[MagicPermissionManager shareManager] iPhoneSystemPermissionReminder];
        [QuicklyHUD showWindowsOnlyTextHUDText:open ? @"已开启" : @"未开启"];
        
    }
    
}

-(void)openPhotoLibrary{
    
    // 进入相册
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:^{
            NSLog(@"打开相册");
        }];
        
    }else{
        NSLog(@"不能打开相册");
    }
    
}

/**
 *  打开系统相机或相册
 */
- (void)openSystemUIImagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType{
    // 创建图像选取控制器对象
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    // 将资源类型设置为相机类型
    picker.sourceType = sourceType;
    // 设置拍照后的图片允许编辑
    picker.allowsEditing = NO;
    // 设置摄像图像品质,默认是UIImagePickerControllerQualityTypeMedium
    picker.videoQuality = UIImagePickerControllerQualityTypeHigh;
    // 设置最长摄像时间,默认是10秒
    picker.videoMaximumDuration = 30;
    // 设置代理,需要遵守<UINavigationControllerDelegate, UIImagePickerControllerDelegate>两个协议
    picker.delegate = self;
    // 弹出图像选取控制器
    [self presentViewController:picker animated:YES completion:nil];
    
}

#pragma mark -UIImagePickerControllerDelegate
// 操作完成
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *resultImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (resultImage != nil) {
        
    }
    
    // 回收图像选取控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
}

// 操作取消
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    // 回收图像选取控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
