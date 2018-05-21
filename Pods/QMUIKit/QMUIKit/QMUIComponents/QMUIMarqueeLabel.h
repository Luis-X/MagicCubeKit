//
//  QMUIMarqueeLabel.h
//  qmui
//
//  Created by MoLice on 2017/5/31.
//  Copyright © 2017年 QMUI Team. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  简易的跑马灯 label 控件，在文字超过 label 可视区域时会自动开启跑马灯效果展示文字，文字滚动时是首尾连接的效果（参考播放音乐时系统锁屏界面顶部的音乐标题）。
 *  @warning lineBreakMode 默认为 NSLineBreakByClipping（UILabel 默认值为 NSLineBreakByTruncatingTail）。
 *  @warning textAlignment 暂不支持 NSTextAlignmentJustified 和 NSTextAlignmentNatural。
 *  @warning 会忽略 numberOfLines 属性，强制以 1 来展示。
 */
@interface QMUIMarqueeLabel : UILabel

/// 控制滚动的速度，1 表示一帧滚动 1pt，10 表示一帧滚动 10pt，默认为 .5，与系统一致。
@property(nonatomic, assign) IBInspectable CGFloat speed;

/// 当文字第一次显示在界面上，以及重复滚动到开头时都要停顿一下，这个属性控制停顿的时长，默认为 2.5（也是与系统一致），单位为秒。
@property(nonatomic, assign) IBInspectable NSTimeInterval pauseDurationWhenMoveToEdge;

/// 用于控制首尾连接的文字之间的间距，默认为 40pt。
@property(nonatomic, assign) IBInspectable CGFloat spacingBetweenHeadToTail;

/**
 *  自动判断 label 的 frame 是否超出当前的 UIWindow 可视范围，超出则自动停止动画。默认为 YES。
 *  @warning 某些场景并无法触发这个自动检测（例如直接调整 label.superview 的 frame 而不是 label 自身的 frame），这种情况暂不处理。
 */
@property(nonatomic, assign) IBInspectable BOOL automaticallyValidateVisibleFrame;

/// 在文字滚动到左右边缘时，是否要显示一个阴影渐变遮罩，默认为 YES。
@property(nonatomic, assign) IBInspectable BOOL shouldFadeAtEdge;

/// 渐变遮罩的宽度，默认为 20。
@property(nonatomic, assign) IBInspectable CGFloat fadeWidth;

/// 渐变遮罩外边缘的颜色，请使用带 Alpha 通道的颜色
@property(nonatomic, strong) IBInspectable UIColor *fadeStartColor;

/// 渐变遮罩内边缘的颜色，一般是 fadeStartColor 的 alpha 通道为 0 的色值
@property(nonatomic, strong) IBInspectable UIColor *fadeEndColor;

/// YES 表示文字会在打开 shouldFadeAtEdge 的情况下，从左边的渐隐区域之后显示，NO 表示不管有没有打开 shouldFadeAtEdge，都会从 label 的边缘开始显示。默认为 NO。
/// @note 如果文字宽度本身就没超过 label 宽度（也即无需滚动），此时必定不会显示渐隐，则这个属性不会影响文字的显示位置。
@property(nonatomic, assign) IBInspectable BOOL textStartAfterFade;
@end


/// 如果在可复用的 UIView 里使用（例如 UITableViewCell、UICollectionViewCell），由于 UIView 可能重复被使用，因此需要在某些显示/隐藏的时机去手动开启/关闭 label 的动画。如果在普通的 UIView 里使用则无需关注这一部分的代码。
@interface QMUIMarqueeLabel (ReusableView)

/**
 *  尝试开启 label 的滚动动画
 *  @return 是否成功开启
 */
- (BOOL)requestToStartAnimation;

/**
 *  尝试停止 label 的滚动动画
 *  @return 是否成功停止
 */
- (BOOL)requestToStopAnimation;
@end
