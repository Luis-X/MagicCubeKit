//
//  WeexViewController.h
//  MagicCubeKit
//
//  Created by LuisX on 2017/11/27.
//  Copyright © 2017年 LuisX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SRWebSocket.h>
@interface WeexViewController : UIViewController<SRWebSocketDelegate>
@property (nonatomic, strong) NSString *script;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) SRWebSocket *hotReloadSocket;
@property (nonatomic, strong) NSString *source;
@end
