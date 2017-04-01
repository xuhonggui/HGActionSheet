//
//  ViewController.m
//  HGActionSheetDemo
//
//  Created by 许鸿桂 on 2017/4/1.
//  Copyright © 2017年 xuhonggui. All rights reserved.
//

#import "ViewController.h"
#import "HGActionSheet.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *serviceTypeBtn;
@property (weak, nonatomic) IBOutlet UIButton *sexBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)sexButtonClick:(id)sender {
    
    NSArray *dataArray = @[@"男", @"女"];
    HGActionSheet *actionSheet = [HGActionSheet createWithTitle:@"" dataSource:dataArray];
    actionSheet.selectIndex = _sexBtn.tag;
    actionSheet.finishSelectBlock = ^(NSInteger index) {
        _sexBtn.tag = index;
        [_sexBtn setTitle:dataArray[index] forState:UIControlStateNormal];
    };
    [actionSheet show];
}

- (IBAction)serviceTypeButtonClick:(id)sender {
    
    NSArray *dataArray = @[@"空调维修", @"洗衣机维修", @"电视维修", @"电脑维修", @"热水器维修", @"抽油烟机维修", @"厕所疏通", @"房屋补漏", @"房屋翻新", @"其它"];
    HGActionSheet *actionSheet = [HGActionSheet createWithTitle:@"服务类型" dataSource:dataArray];
    actionSheet.selectIndex = _serviceTypeBtn.tag;
    actionSheet.finishSelectBlock = ^(NSInteger index) {
        _serviceTypeBtn.tag = index;
        [_serviceTypeBtn setTitle:dataArray[index] forState:UIControlStateNormal];
    };
    [actionSheet show];
}


@end
