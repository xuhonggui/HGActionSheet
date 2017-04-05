/*
 The MIT License (MIT)
 
 Copyright (c) 2017, xuhonggui.
 All rights reserved.
 */

#import <UIKit/UIKit.h>

@class HGActionSheet;

@protocol HGActionSheetDelegate <NSObject>
- (void)actionSheet:(HGActionSheet*)actionSheet finishSelect:(NSInteger)index;
@end

typedef void(^FinishSelectBlock)(NSInteger index);

@interface HGActionSheet : UIView

/**
 * 初始化
 * params dataArr 列表数据
 */
+ (instancetype)createWithDataSource:(NSArray*)dataArr;

/**
 * 初始化
 * params title 标题，支持空字符串
 * params dataArr 列表数据
 */
+ (instancetype)createWithTitle:(NSString*)title
                    dataSource:(NSArray*)dataArr;

/**
 * 初始化
 * params title 标题，支持空字符串
 * params dataArr 列表数据
 * params index 选择的行
 */
+ (instancetype)createWithTitle:(NSString*)title
                     dataSource:(NSArray*)dataArr
                    selectIndex:(NSInteger)index;

/**
 * 初始化
 * params title 标题，支持空字符串
 * params dataArr 列表数据
 * params index 选择的行
 * params block 选择结束回调
 */
+ (instancetype)createWithTitle:(NSString*)title
                      dataSource:(NSArray*)dataArr
                    selectIndex:(NSInteger)index
           finishSelectBlock:(FinishSelectBlock)block;

/**
 * 初始化
 * params title 标题，支持空字符串
 * params dataArr 列表数据
 * params index 选择的行
 * params delegate 代理
 */
+ (instancetype)createWithTitle:(NSString*)title
                     dataSource:(NSArray*)dataArr
                    selectIndex:(NSInteger)index
                       delegate:(id)delegate;

/**
 * 显示
 */
- (void)show;

/**
 * 隐藏
 */
- (void)hide;

/**
 * 选择完成回调
 */
@property (nonatomic, copy) FinishSelectBlock finishSelectBlock;

/**
 * 当前选中行
 */
@property (nonatomic, assign) NSInteger selectIndex;

/**
 * 代理
 */
@property (nonatomic, weak) id<HGActionSheetDelegate> delegate;

@end
