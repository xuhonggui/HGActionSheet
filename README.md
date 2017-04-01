# HGActionSheet
弹出菜单<br>
<img src="https://github.com/xuhonggui/HGTimerButton/raw/master/Image/image1.png" width=35% heithg=35% />
<img src="https://github.com/xuhonggui/HGTimerButton/raw/master/Image/image2.png" width=35% heithg=35% />
<img src="https://github.com/xuhonggui/HGTimerButton/raw/master/Image/image3.png" width=35% heithg=35% />
# How to Use
### 使用CocoaPods<br>
```
pod 'HGActionSheet'
```
### 手动导入<br>
将HGActionSheet文件夹中所有源代码拽入项目中，导入头文件`import "HGActionSheet.h"`<br>
### 示例:<br>
创建对象
```
NSArray *dataArray = @[@"空调维修", @"洗衣机维修", @"电视维修", @"电脑维修", @"热水器维修", @"抽油烟机维修", @"厕所疏通", @"房屋补漏", @"房屋翻新", @"其它"];
HGActionSheet *actionSheet = [HGActionSheet createWithTitle:@"服务类型" dataSource:dataArray];

```
设置选中的行:<br>
```
actionSheet.selectIndex = 0;
```
设置回调block或者delegate:<br>
```
actionSheet.finishSelectBlock = ^(NSInteger index) {
    //do something ...
};
```
弹出:<br>
```
[actionSheet show];
```
# License
MIT

