# WYPickerViews
几种常用的选择器
***
# 1、是什么？
该 Demo 是我常用的几种 pickerView，也有一个长文本输入的 controller。
***
# 2、效果展示
![WYPickerViews.gif](https://github.com/yiyi0202/WYPickerViews/blob/master/WYEditInfoDemo/WYPickerViews.gif)
***
# 3、使用方法
（1）下载 [WYPickerViews](https://github.com/yiyi0202/WYPickerViews)，直接将 Demo 里的 **WYPickerViews** 文件夹拖入项目中，也可将 **WYTableViewCellWithLabel** 和 **WYTableViewCellWithImageView** 拖入项目中（或者自定义自己的 cell）；

（2）在使用 pickerView 的控制器里导入头文件：
```
#import "WYGenderPickerView.h"
#import "WYBirthdayPickerView.h"
#import "WYHeightPickerView.h"
#import "WYCityPickerView.h"
```
（3）在指定的触发事件里实例化相对应的 pickerView：
### 性别
```
// initialGender 参数 : genderPickerView 初始化显示时要显示的性别
WYGenderPickerView *genderPickerView = [[WYGenderPickerView alloc] initWithInitialGender:self.gender];

// 选择性别完成之后的回调 : 按自己的要求做相应的处理就可以了
genderPickerView.confirmBlock = ^(NSString *selectedGender) {
    
    // 新数据提交服务器
    
    // 在提交成功的回调里修改本地变量并刷新 UI
    self.gender = selectedGender;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:2]] withRowAnimation:(UITableViewRowAnimationNone)];
};

[self.tableView addSubview:genderPickerView];
```
### 生日
```
// initialDate 参数 : birthdayPickerView 初始化显示时要显示的日期
WYBirthdayPickerView *birthdayPickerView = [[WYBirthdayPickerView alloc] initWithInitialDate:self.birthday];

// 选择日期完成之后的回调 : 按自己的要求做相应的处理就可以了
birthdayPickerView.confirmBlock = ^(NSString *selectedDate) {
    
    // 新数据提交服务器
    
    // 在提交成功的回调里修改本地变量并刷新 UI
    self.birthday = selectedDate;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:2]] withRowAnimation:(UITableViewRowAnimationNone)];
};

[self.tableView addSubview:birthdayPickerView];
```
### 身高
```
// initialHeight 参数 : heightPickerView 初始化显示时要显示的身高
WYHeightPickerView *heightPickerView = [[WYHeightPickerView alloc] initWithInitialHeight:self.height];

// 选择身高完成之后的回调 : 按自己的要求做相应的处理就可以了
heightPickerView.confirmBlock = ^(NSString *selectedHeight) {
    
    // 新数据提交服务器
    
    // 在提交成功的回调里修改本地变量并刷新 UI
    self.height = selectedHeight;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:2]] withRowAnimation:(UITableViewRowAnimationNone)];
};

[self.tableView addSubview:heightPickerView];
```
### 城市
```
// initialCity 参数 : cityPickerView 初始化显示时要显示的城市
WYCityPickerView *cityPickerView = [[WYCityPickerView alloc] initWithInitialCity:self.city];

// 选择城市完成之后的回调 : 按自己的要求做相应的处理就可以了
cityPickerView.confirmBlock = ^(NSString *selectedCity) {
    
    // 新数据提交服务器
    
    // 在提交成功的回调里修改本地变量并刷新 UI
    self.city = selectedCity;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:2]] withRowAnimation:(UITableViewRowAnimationNone)];
};

[self.tableView addSubview:cityPickerView];
```
***
# 4. 完成
做了以上工作，就可以完成常用的几种选择器。
***
