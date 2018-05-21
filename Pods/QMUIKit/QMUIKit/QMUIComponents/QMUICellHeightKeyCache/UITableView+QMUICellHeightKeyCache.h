//
//  UITableView+QMUICellHeightKeyCache.h
//  QMUIKit
//
//  Created by MoLice on 2018/3/14.
//  Copyright © 2018年 QMUI Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class QMUICellHeightKeyCache;

/**
 *  自动缓存 self-sizing cell 的高度，避免重复计算。使用方法：
 *  1. 将 tableView.qmui_cacheCellHeightByKeyAutomatically = YES
 *  2. 实现 tableView 的 delegate 方法 qmui_tableView:cacheKeyForRowAtIndexPath: 返回一个 key。建议 key 由所有可能影响高度的字段拼起来，这样当数据发生变化时不需要手动更新缓存。
 *
 *  @note 注意这里的高度缓存仅适合于使用 self-sizing 机制的 tableView（也即 tableView.rowHeight = UITableViewAutomaticDimension），QMUICellHeightKeyCache 会自动在 willDisplayCell 里将 cell 的当前高度缓存起来，然后在 heightForRow 里从缓存中读取高度后使用。而如果你的 tableView 并没有使用 self-sizing 机制（也即自己重写了 heightForRow），则请勿使用本控件的功能。
 *
 *  @note 在 UITableView 的宽度和 contentInset 发生变化时（例如横竖屏旋转、iPad 分屏），高度缓存会自动刷新，所以无需为这种情况做保护。
 */
@interface UITableView (QMUICellHeightKeyCache)

/// 控制是否要自动缓存 cell 的高度，默认为 NO
@property(nonatomic, assign) BOOL qmui_cacheCellHeightByKeyAutomatically;

/// 获取当前的缓存容器。tableView 的宽度和 contentInset 发生变化时，这个数组也会跟着变，但当 tableView 宽度小于 0 时会返回 nil。
@property(nonatomic, weak, readonly, nullable) QMUICellHeightKeyCache *qmui_currentCellHeightKeyCache;

/// 清除所有状态下的缓存
- (void)qmui_invalidateAllCellHeightKeyCache;
@end
