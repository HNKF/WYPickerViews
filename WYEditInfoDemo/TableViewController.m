//
//  TableViewController.m
//  WYDatePickerViewDemo
//
//  Created by 意一yiyi on 2017/3/6.
//  Copyright © 2017年 意一yiyi. All rights reserved.
//

#import "TableViewController.h"

#import "WYTableViewCellWithBigImageView.h"
#import "WYTableViewCellWithLabel.h"
#import "WYTableViewCellWithBigLabel.h"

#import "WYGenderPickerView.h"
#import "WYBirthdayPickerView.h"
#import "WYHeightPickerView.h"
#import "WYCityPickerView.h"

#import "NicknameViewController.h"
#import "SignatureViewController.h"

@interface TableViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

// 修改之后的数据虽然上传到了服务器, 但是不能立马去读取, 而是借助本地的这些变量(或者 user 的属性)先完成展示的效果, 下次进这个界面的时候再从服务器读取数据

// 头像相关
@property (strong, nonatomic) UIImagePickerController *imgPickerController;
@property (assign, nonatomic) BOOL isPhotoAlbum;
@property (strong, nonatomic) UIImage *selectedImg;// 从相册选取或者拍照后选取的照片, 如果有值说明是编辑了, 否则就是非编辑
// 头像相关

@property (strong, nonatomic) NSString *nickname;
@property (strong, nonatomic) NSString *signature;
@property (strong, nonatomic) NSString *gender;
@property (strong, nonatomic) NSString *birthday;
@property (strong, nonatomic) NSString *height;
@property (strong, nonatomic) NSString *city;

@end

@implementation TableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    
    if ([super initWithStyle:UITableViewStyleGrouped]) {
        
        
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithRed:242 / 255.0 green:242 / 255.0 blue:242 / 255.0 alpha:1];

    [self initialize];
    
    [self createVC];
}


#pragma mark - initialize

- (void)initialize {
    
    // 这里应该从服务器读取用户的数据
//    self.birthday = 服务器的 birthday;
//    self.height = 服务器的 height;
}


#pragma mark - createVC

- (void)createVC {
    
    // 导航栏
    self.navigationItem.title = @"编辑资料";
    
    // 有导航栏和 tabBar 的情况下, 自动让布局从导航栏下边和 tabBar 上边开始布局
    if ([self performSelector:@selector(setEdgesForExtendedLayout:)]) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self tableViewConfiguration];
}


#pragma mark - 相册和相机代理方法

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    if (self.imgPickerController.sourceType == UIImagePickerControllerSourceTypeSavedPhotosAlbum) {// 相册选取图片
        
        // 获取到这个图片
        if (self.imgPickerController.allowsEditing) {
            
            // 获取编辑后的图片
            self.selectedImg = info[@"UIImagePickerControllerEditedImage"];
        }else {
            
            // 获取原始图片
            self.selectedImg = info[@"UIImagePickerControllerOriginalImage"];
        }
        
        
        // 新数据提交服务器
        
        // 在提交成功的回调里刷新 UI
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:(UITableViewRowAnimationNone)];
    }else if (self.imgPickerController.sourceType == UIImagePickerControllerSourceTypeCamera) {// 拍照
        
        // 获取到这个图片
        if (self.imgPickerController.allowsEditing) {
            
            // 获取编辑后的图片
            self.selectedImg = info[@"UIImagePickerControllerEditedImage"];
        }else {
            
            // 获取原始图片
            self.selectedImg = info[@"UIImagePickerControllerOriginalImage"];
        }
        
        UIImageWriteToSavedPhotosAlbum(self.selectedImg, self, @selector(photo:didFinishSavingWithError:contextInfo:), nil);
    }
    
    // 模态走imgPicker
    [self dismissViewControllerAnimated:YES completion:nil];
}
// 代理方法(2) : 用户作出取消动作时会触发的方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    // 模态走imgPicker
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  照片保存后的回调
 第一个参数 : 拍到并保存在本地的照片
 */
- (void)photo:(UIImage *)photo didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    if (!error) {
        
        // 新数据提交服务器
        
        // 在提交成功的回调里刷新 UI
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:(UITableViewRowAnimationNone)];
    }else{
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"照片保存错误，请稍后重试！" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *defaltAction = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDefault) handler:nil];
        [alertController addAction:defaltAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}


#pragma mark - tableView

- (void)tableViewConfiguration {
    
    [self.tableView registerClass:[WYTableViewCellWithBigImageView class] forCellReuseIdentifier:wyTableViewCellWithBigImageViewReuseID];
    [self.tableView registerClass:[WYTableViewCellWithLabel class] forCellReuseIdentifier:wyTableViewCellWithLabelReuseID];
    [self.tableView registerClass:[WYTableViewCellWithBigLabel class] forCellReuseIdentifier:wyTableViewCellWithBigLabelReuseID];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 1;
    }else if (section == 1) {
        
        return 2;
    }else {
        
        return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 || (indexPath.section == 1 && indexPath.row == 1)) {
        
        return 88;
    }else {
        
        return 44;
    }
}

static NSString * const wyTableViewCellWithBigImageViewReuseID = @"wyTableViewCellWithBigImageViewReuseID";
static NSString * const wyTableViewCellWithLabelReuseID = @"wyTableViewCellWithLabelReuseID";
static NSString * const wyTableViewCellWithBigLabelReuseID = @"wyTableViewCellWithBigLabelReuseID";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        WYTableViewCellWithBigImageView *tableViewCellWithBigImageView = [self.tableView dequeueReusableCellWithIdentifier:wyTableViewCellWithBigImageViewReuseID forIndexPath:indexPath];
        tableViewCellWithBigImageView.backgroundColor = [UIColor whiteColor];
        
        tableViewCellWithBigImageView.textLabel.text = @"头像";

        if (self.selectedImg == NULL) {// 说明用户没有编辑, 那就读取用户在服务器上的头像
            
//            [tableViewCellWithBigImageView.accessoryImageView sd_setImageWithURL:[NSURL URLWithString:[WYSingletonTools sharedWYSingletonTools].currentUser.avatar] placeholderImage:[UIImage imageNamed:@"头像占位图"]];
            
            // 这里先展示占位图
            tableViewCellWithBigImageView.accessoryImageView.image = [UIImage imageNamed:@"头像占位图.jpg"];
        }else {// 否则说明用户编辑了
            
            tableViewCellWithBigImageView.accessoryImageView.image = self.selectedImg;
        }
        
        return tableViewCellWithBigImageView;
    }else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            WYTableViewCellWithLabel *tableViewCellWithLabel = [self.tableView dequeueReusableCellWithIdentifier:wyTableViewCellWithLabelReuseID forIndexPath:indexPath];
            tableViewCellWithLabel.backgroundColor = [UIColor whiteColor];
            
            tableViewCellWithLabel.textLabel.text = @"昵称";
            
            // 有昵称则显示昵称, 否则提示用户编辑
            if (self.nickname.length == 0) {
                
                tableViewCellWithLabel.accessoryLabel.text = @"请编辑";
            }else {
                
                tableViewCellWithLabel.accessoryLabel.text = self.nickname;
            }
            
            return tableViewCellWithLabel;
        }else {
            
            WYTableViewCellWithBigLabel *tableViewCellWithBigLabel = [self.tableView dequeueReusableCellWithIdentifier:wyTableViewCellWithBigLabelReuseID forIndexPath:indexPath];
            tableViewCellWithBigLabel.backgroundColor = [UIColor whiteColor];
            
            tableViewCellWithBigLabel.textLabel.text = @"个性签名";
            
            // 有个性签名则显示个性签名, 否则提示用户编辑
            if (self.signature.length == 0) {
                
                tableViewCellWithBigLabel.accessoryLabel.text = @"请编辑";
            }else {
                
                tableViewCellWithBigLabel.accessoryLabel.text = self.signature;
            }
            
            return tableViewCellWithBigLabel;
        }
    }else {
        
        WYTableViewCellWithLabel *tableViewCellWithLabel = [self.tableView dequeueReusableCellWithIdentifier:wyTableViewCellWithLabelReuseID forIndexPath:indexPath];
        tableViewCellWithLabel.backgroundColor = [UIColor whiteColor];
        
        if (indexPath.row == 0) {
    
            tableViewCellWithLabel.textLabel.text = @"性别";
            
            // 有性别则显示性别, 否则提示用户选择
            if (self.gender.length == 0) {
                
                tableViewCellWithLabel.accessoryLabel.text = @"请选择";
            }else {
                
                tableViewCellWithLabel.accessoryLabel.text = self.gender;
            }
        }else if (indexPath.row == 1) {
            
            tableViewCellWithLabel.textLabel.text = @"生日";
        
            // 有生日则显示生日, 否则提示用户选择
            if (self.birthday.length == 0) {
                
                tableViewCellWithLabel.accessoryLabel.text = @"请选择";
            }else {
                
                tableViewCellWithLabel.accessoryLabel.text = self.birthday;
            }
        }else if (indexPath.row == 2) {
            
            tableViewCellWithLabel.textLabel.text = @"身高";
            
            // 有身高则显示身高, 否则提示用户选择
            if (self.height.length == 0) {
                
                tableViewCellWithLabel.accessoryLabel.text = @"请选择";
            }else {
                
                tableViewCellWithLabel.accessoryLabel.text = self.height;
            }
        }else {
            
            tableViewCellWithLabel.textLabel.text = @"城市";
            
            // 有城市则显示城市, 否则提示用户选择
            if (self.city.length == 0) {
                
                tableViewCellWithLabel.accessoryLabel.text = @"请选择";
            }else {
                
                tableViewCellWithLabel.accessoryLabel.text = self.city;
            }
        }
        
        return tableViewCellWithLabel;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        // 选取头像方式 alertController
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
        UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册选取" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            self.isPhotoAlbum = YES;
            [self presentViewController:self.imgPickerController animated:YES completion:nil];
        }];
        UIAlertAction *videoAction = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            self.isPhotoAlbum = NO;
            [self presentViewController:self.imgPickerController animated:YES completion:nil];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
        
        [alertController addAction:videoAction];
        [alertController addAction:photoAction];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            
            NicknameViewController *nicknameVC = [[NicknameViewController alloc] init];
            nicknameVC.nickname = self.nickname;
            nicknameVC.maxCharacterNum = 15;// 可输入的最大字符数
            nicknameVC.warningColor = [UIColor orangeColor];// 超出字数限制时的警告色
            
            // 完成编辑之后的回调 : 按自己的要求做相应的处理就可以了
            nicknameVC.block = ^(NSString *nickname) {
                
                // 修改本地变量并刷新 UI
                self.nickname = nickname;
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:(UITableViewRowAnimationNone)];
            };
            [self.navigationController pushViewController:nicknameVC animated:YES];
        }else {
            
            SignatureViewController *signatureVC = [[SignatureViewController alloc] init];
            signatureVC.signature = self.signature;
            signatureVC.maxCharacterNum = 64;// 可输入的最大字符数
            signatureVC.warningColor = [UIColor orangeColor];// 超出字数限制时的警告色
            
            // 完成编辑之后的回调 : 按自己的要求做相应的处理就可以了
            signatureVC.block = ^(NSString *signature) {
                
                // 修改本地变量并刷新 UI
                self.signature = signature;
                [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:(UITableViewRowAnimationNone)];
            };
            [self.navigationController pushViewController:signatureVC animated:YES];
        }
    }else {
        
        if (indexPath.row == 0) {
        
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
        }else if (indexPath.row == 1) {
            
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
        }else if (indexPath.row == 2) {
            
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
        }else {
            
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
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.000001;
}


#pragma mark - 懒加载

- (UIImagePickerController *)imgPickerController {
    
    // 调用 imgPickerController 的时候, 判断一下是否支持相册或者摄像头功能
    if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeSavedPhotosAlbum)] && [UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeCamera)]) {
        
        if (!_imgPickerController) {
            
            _imgPickerController = [[UIImagePickerController alloc] init];
            _imgPickerController.delegate = self;
            // 产生的媒体文件是否可进行编辑
            _imgPickerController.allowsEditing = YES;
            // 媒体类型
            _imgPickerController.mediaTypes = @[@"public.image"];
        }
        
        if (self.isPhotoAlbum) {
            
            // 媒体源, 这里设置为相册
            _imgPickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }else{
            
            // 媒体源, 这里设置为摄像头
            _imgPickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            // 摄像头, 这里设置默认使用后置摄像头
            _imgPickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
            // 摄像头模式, 这里设置为拍照模式
            _imgPickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        }
        
        return _imgPickerController;
    }else{
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您的设备不支持此功能!" preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *defaltAction = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDefault) handler:nil];
        
        [alertController addAction:defaltAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        return nil;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
