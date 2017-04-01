//
//  HGActionSheet.m
//  BobBuilder
//
//  Created by 许鸿桂 on 2017/3/31.
//  Copyright © 2017年 dlc. All rights reserved.
//

#import "HGActionSheet.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kRowHeight 44

@interface HGActionSheetTitleView : UIView

/**
 * 标题
 */
- (void)setTitle:(NSString*)title count:(NSInteger)count;

@end

@interface HGActionSheetTitleView ()
{
    UILabel *_titleLab;
}
@end

@implementation HGActionSheetTitleView

- (instancetype)init {
    if (self = [super init]) {
        UIView *topLine = [[UIView alloc] init];
        topLine.frame = CGRectMake(0, 0, kScreenW, 0.5);
        topLine.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:topLine];
        
        UIView *bottomLine = [[UIView alloc] init];
        bottomLine.frame = CGRectMake(0, 39.5, kScreenW, 0.5);
        bottomLine.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:bottomLine];
        
        _titleLab = [[UILabel alloc] init];
        _titleLab.frame = CGRectMake(15, 10, kScreenW - 30, 20);
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:18];
        [self addSubview:_titleLab];
    }
    return self;
}

- (void)setTitle:(NSString*)title count:(NSInteger)count {
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] init];
    [string appendAttributedString:[self getAttributedString:title color:[UIColor lightGrayColor]]];
    [string appendAttributedString:[self getAttributedString:@"(共 " color:[UIColor lightGrayColor]]];
    [string appendAttributedString:[self getAttributedString:[@(count) description] color:[UIColor redColor]]];
    [string appendAttributedString:[self getAttributedString:@" 项)" color:[UIColor lightGrayColor]]];
    _titleLab.attributedText = string;
}

- (NSAttributedString*)getAttributedString:(NSString*)string color:(UIColor*)color {
    return [[NSAttributedString alloc] initWithString:string attributes:@{NSForegroundColorAttributeName: color}];
}

@end

@interface HGActionSheet ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *_dataArr;
    CGFloat _tableViewHeight;
    NSString *_title;
    HGActionSheetTitleView *_titleView;
}
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation HGActionSheet

- (instancetype)initWithTitle:(NSString*)title
                   dataSource:(NSArray*)dataArr
{
    NSAssert([dataArr isKindOfClass:[NSArray class]], @"dataSource should be subClass of NSArray");
    if (self = [super initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)]) {
        _title = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];;
        _dataArr = dataArr;
        _tableViewHeight = _dataArr.count >= 5 ? (kRowHeight * 5) : (_dataArr.count * kRowHeight);
        _selectIndex = 0;
        [self initialize];
    }
    return self;
}

+ (instancetype)createWithDataSource:(NSArray*)dataArr
{
    return [[self alloc] initWithTitle:@"" dataSource:dataArr];
}

+ (instancetype)createWithTitle:(NSString*)title
                     dataSource:(NSArray*)dataArr
{
    return [[self alloc] initWithTitle:title dataSource:dataArr];
}

+ (instancetype)createWithTitle:(NSString*)title
                     dataSource:(NSArray*)dataArr
                    selectIndex:(NSInteger)index
{
    HGActionSheet *actionSheet = [[self alloc] initWithTitle:title dataSource:dataArr];
    actionSheet.selectIndex = index;
    return actionSheet;
}

+ (instancetype)createWithTitle:(NSString*)title
                     dataSource:(NSArray*)dataArr
                    selectIndex:(NSInteger)index
              finishSelectBlock:(FinishSelectBlock)block
{
    HGActionSheet *actionSheet = [[self alloc] initWithTitle:title dataSource:dataArr];
    actionSheet.selectIndex = index;
    actionSheet.finishSelectBlock = block;
    return actionSheet;
}

+ (instancetype)createWithTitle:(NSString*)title
                     dataSource:(NSArray*)dataArr
                    selectIndex:(NSInteger)index
                       delegate:(id)delegate {
    HGActionSheet *actionSheet = [[self alloc] initWithTitle:title dataSource:dataArr];
    actionSheet.selectIndex = index;
    actionSheet.delegate = delegate;
    return actionSheet;
}

#pragma mark - initialize

- (void)initialize {
    
    [self addSubview:self.backgroundView];
    [self createTitleView];
    [self createTableView];
}

- (void)createTableView {
    [self addSubview:self.tableView];
}

- (void)createTitleView {
    
    if (_title.length == 0) return;
    
    _titleView = [[HGActionSheetTitleView alloc] init];
    _titleView.frame = CGRectMake(0, kScreenH, kScreenW, 40);
    _titleView.backgroundColor = [UIColor whiteColor];
    [_titleView setTitle:_title count:_dataArr.count];
    [self addSubview:_titleView];
}

#pragma mark - setter

- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0]
                          atScrollPosition:UITableViewScrollPositionMiddle
                                  animated:NO];
}

#pragma mark - public method

- (void)show {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.4 animations:^{
        _backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        _tableView.frame = CGRectMake(0, kScreenH - _tableViewHeight, kScreenW, _tableViewHeight);
        _titleView.frame = CGRectMake(0, kScreenH - _tableViewHeight - 40, kScreenW, 40);
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.4 animations:^{
        _backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        _tableView.frame = CGRectMake(0, kScreenH + 40, kScreenW, _tableViewHeight);
        _titleView.frame = CGRectMake(0, kScreenH, kScreenW, 40);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        
        UIImageView *arrow = [[UIImageView alloc] init];
        arrow.frame = CGRectMake(kScreenW - 31, 16, 16, 12);
        arrow.tag = 1001;
        [cell.contentView addSubview:arrow];
    }
    
    cell.textLabel.text = _dataArr[indexPath.row];
    UIImageView *arrow = [cell.contentView viewWithTag:1001];
    arrow.image = _selectIndex == indexPath.row ? [UIImage imageNamed:@"ico_make"] : nil;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kRowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /* don't need to call the selectIndex's setter method */
    _selectIndex = indexPath.row;
    
    if (_finishSelectBlock) {
        _finishSelectBlock(indexPath.row);
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(actionSheet:finishSelect:)]) {
        [_delegate actionSheet:self finishSelect:indexPath.row];
    }
    
    [self hide];
}

#pragma mark - 懒加载

- (UIView*)backgroundView {
    if (!_backgroundView) {
        UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        _backgroundView = backgroundView;
    }
    return _backgroundView;
}

- (UITableView*)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kScreenH + 40, kScreenW, _tableViewHeight)
                                                              style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        _tableView = tableView;
    }
    return _tableView;
}

#pragma mark - 触碰事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (CGRectContainsPoint(self.tableView.frame, point)
        || CGRectContainsPoint(_titleView.frame, point)) {
        return;
    }
    [self hide];
}

@end
