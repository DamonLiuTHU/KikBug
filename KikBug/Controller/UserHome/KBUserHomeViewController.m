//
//  KBUserHomeViewController.m
//  KikBug
//
//  Created by DamonLiu on 15/11/10.
//  Copyright © 2015年 DamonLiu. All rights reserved.
//

#import "DNImagePickerController.h"
#import "KBImageManager.h"
#import "KBSimpleEditorViewController.h"
#import "KBUserAvatarCell.h"
#import "KBUserHomeCellModel.h"
#import "KBUserHomeViewController.h"
#import "KBUserInfoManager.h"
#import "KBUserInfoModel.h"
#import "KBUserNameCell.h"
#import "KBUserSimpleInfoCell.h"
#import "KBLogOutCell.h"
#import "KBLoginManager.h"
#import "KBLoginViewController.h"

@interface KBUserHomeViewController () <DNImagePickerControllerDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, KBSimpleEditorViewControllerDelegate>
//@property (strong, nonatomic) UIButton* loginButton;

@property (strong, nonatomic) UILabel* registerDate;
@property (strong, nonatomic) UILabel* credit;

@property (strong, nonatomic) UILabel* registerDateHint;
@property (strong, nonatomic) UILabel* creditHint;

@property (strong, nonatomic) UIButton* editBtn;

@property (strong, nonatomic) NSArray<KBUserHomeCellModel*>* dataSource;

@property (strong, nonatomic) KBUserInfoModel* model;

@end

@implementation KBUserHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];

    //    if (YES) {
    //        KBViewController* loginVC = (KBViewController *)[[HHRouter shared] matchController:LOGIN_PAGE_NAME];
    //        [[KBNavigator sharedNavigator] showViewController:loginVC withShowType:KBUIManagerShowTypePresent];
    //    }

//    self.loginButton = [UIButton new];
//    [self.loginButton setBackgroundColor:THEME_COLOR];
//    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [self.view addSubview:self.loginButton];
//    [self.loginButton.layer setCornerRadius:5.0f];
//    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
//    [self.loginButton addTarget:self action:@selector(showLoginButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)configTableView
{
    [super configTableView];
    [self.tableView setBackgroundColor:[UIColor colorWithHexNumber:0xe3e3e3]];
}

- (void)loadData
{
    [[KBUserInfoManager manager] fetchUserInfoCompletion:^(KBUserInfoModel* model, NSError* error) {
        [self endRefreshing];
        self.model = model;
        [self createDataSourceWithModel];
    }];
    //    KBUserInfoModel* model = [[KBUserInfoManager manager] storedUserInfoForUserId:STORED_USER_ID];
    //    if (!model) {
    //
    //    }
    //    else {
    //        [self endRefreshing];
    //        self.model = model;
    //        [self createDataSourceWithModel];
    //    }
}

/**
 *  组织内容的Model
 */
- (void)createDataSourceWithModel
{
    NSMutableArray<KBUserHomeCellModel*>* array = [NSMutableArray array];

    //头像
    [array addObject:[KBUserHomeCellModel emptyCellWithHeight:10.0f]];
    KBUserHomeCellModel* cellModel = [[KBUserHomeCellModel alloc] initWithClass:[KBUserAvatarCell class] cellHeight:90.0f model:self.model];
    [array addObject:cellModel];

    //昵称
    KBUserHomeCellModel* nickNameCellModel = [[KBUserHomeCellModel alloc] initWithClass:[KBUserNameCell class] cellHeight:[KBUserNameCell cellHeight] model:self.model];
    [array addObject:nickNameCellModel];
    
    //登出
     [array addObject:[KBUserHomeCellModel emptyCellWithHeight:20.0f]];
    KBUserHomeCellModel *logoutModel = [[KBUserHomeCellModel alloc] initWithClass:[KBLogOutCell class] cellHeight:[KBLogOutCell cellHeight] model:nil];
    [array addObject:logoutModel];

    self.dataSource = array;

    [self.tableView reloadData];
}

//- (void)showLoginButton
//{
//    KBViewController* loginVC = (KBViewController*)[[HHRouter shared] matchController:LOGIN_PAGE_NAME];
//    [[KBNavigator sharedNavigator] showViewController:loginVC withShowType:KBUIManagerShowTypePresent];
//}

//- (void)configConstrains
//{
//    [super configConstrains];
////    [self.loginButton autoSetDimensionsToSize:CGSizeMake(200, 50)];
////    [self.loginButton autoAlignAxisToSuperviewAxis:ALAxisVertical];
////    [self.loginButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:BOTTOM_BAR_HEIGHT + 10];
//    [super updateViewConstraints];
//}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate for table view
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return self.dataSource[indexPath.row].cellHeight;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    Class cls = self.dataSource[indexPath.row].cellClass;
    id cell = [cls cellForTableView:tableView];
    if ([cell respondsToSelector:@selector(bindModel:)]) {
        [cell performSelector:@selector(bindModel:) withObject:self.model];
    }
    return cell;
}

#pragma mark - UI Event

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    KBUserHomeCellModel* model = self.dataSource[indexPath.row];
    if ([model.cellClass hash] == [[KBUserAvatarCell class] hash]) {
        [self chooseAvatarPage];
    }

    if (model.cellClass == [KBUserNameCell class]) {
        [self editNickName];
    }
    
    if (model.cellClass == [KBLogOutCell class]) {
        [self logOutButtonPressed];
    }
}

#pragma mark - Jump to other pages
- (void)chooseAvatarPage
{
    UIActionSheet* actionSheet = [[UIActionSheet alloc]
                 initWithTitle:@"请选择文件来源"
                      delegate:self
             cancelButtonTitle:@"取消"
        destructiveButtonTitle:nil
             otherButtonTitles:@"照相机", @"本地相簿", nil];
    [actionSheet showInView:self.view];
}

- (void)editNickName
{
    UIViewController* vc = [[HHRouter shared] matchController:SIMPLE_EDITOR];
    [vc setValue:self forKeyPath:@"delegate"];
    [vc setParams:@{ @"text" : self.model.name }];
    [UIManager showViewController:vc];
}

- (void)logOutButtonPressed
{
//    UIActionSheet* actionSheet = [[UIActionSheet alloc]
//                                  initWithTitle:@"请选择文件来源"
//                                  delegate:self
//                                  cancelButtonTitle:@"取消"
//                                  destructiveButtonTitle:nil
//                                  otherButtonTitles:@"照相机", @"本地相簿", nil];
//    [actionSheet showInView:self.view];
    [KBLoginManager userLogOut];
    KBLoginViewController *vc = [UIManager showLoginPageIfNeededWithSuccessCompletion:^{
        [UIManager showRootViewController];
    }];
    vc.navigationItem.leftBarButtonItem = nil;
    
}

#pragma mark - DNI Delegate
- (void)dnImagePickerController:(DNImagePickerController*)imagePickerController sendImages:(NSArray<DNAsset*>*)imageAssets isFullImage:(BOOL)fullImage
{
}

- (void)dnImagePickerControllerDidCancel:(DNImagePickerController*)imagePicker
{
    [imagePicker dismissViewControllerAnimated:YES completion:^{

    }];
}

#pragma mark -

#pragma mark -
#pragma UIActionSheet Delegate
- (void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //    NSLog(@"buttonIndex = [%d]",buttonIndex);
    switch (buttonIndex) {
    case 0: //照相机
    {
        UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        //			[self presentModalViewController:imagePicker animated:YES];
        [self presentViewController:imagePicker animated:YES completion:nil];
    } break;
    //        case 1://摄像机
    //        {
    //            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    //            imagePicker.delegate = self;
    //            imagePicker.allowsEditing = YES;
    //            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //            imagePicker.videoQuality = UIImagePickerControllerQualityTypeLow;
    //            //			[self presentModalViewController:imagePicker animated:YES];
    //            [self presentViewController:imagePicker animated:YES completion:nil];
    //        }
    //            break;
    case 1: //本地相簿
    {
        UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //			[self presentModalViewController:imagePicker animated:YES];
        [self presentViewController:imagePicker animated:YES completion:nil];
    } break;
    //        case 3://本地视频
    //        {
    //            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    //            imagePicker.delegate = self;
    //            imagePicker.allowsEditing = YES;
    //            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //            //			[self presentModalViewController:imagePicker animated:YES];
    //            [self presentViewController:imagePicker animated:YES completion:nil];
    //        }
    //            break;
    default:
        break;
    }
}

#pragma mark -
#pragma UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary*)info
{
    UIImage* image = info[UIImagePickerControllerEditedImage];
    [self saveImage:image];
    [[KBUserInfoManager manager] saveUserInfo:self.model];
    [self createDataSourceWithModel];

    [picker dismissViewControllerAnimated:YES completion:nil];

    //更新在线数据
    self.model.avatarLocation = [KBImageManager uploadImage:image Completion:^(NSString* url, NSError* error) {
        if (!error) {
            NSLog(@"Image upload success with url :%@", [KBImageManager fullImageUrlWithUrl:url]);
        }
    }];
    [[KBUserInfoManager manager] saveUserInfo:self.model];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController*)picker
{
    //	[picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImage:(UIImage*)image
{
    //	NSLog(@"保存头像！");
    //	[userPhotoButton setImage:image forState:UIControlStateNormal];
    BOOL success;
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSError* error;

    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    NSString* imageFilePath = [documentsDirectory stringByAppendingString:@"/avatarOrignal.jpg"];
    NSString* thumbnailImagePath = [documentsDirectory stringByAppendingString:@"/avatarThumbnail.jpg"];
    //    NSLog(@"imageFile->>%@",imageFilePath);
    success = [fileManager fileExistsAtPath:imageFilePath];
    if (success) {
        success = [fileManager removeItemAtPath:imageFilePath error:&error];
    }
    //    UIImage *smallImage=[self scaleFromImage:image toSize:CGSizeMake(80.0f, 80.0f)];//将图片尺寸改为80*80
    UIImage* smallImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(93, 93)];
    //    [UIImage grepresentation(smallImage, 1.0f) writeToFile:imageFilePath atomically:YES];//写入文件
    [UIImageJPEGRepresentation(smallImage, 1.0f) writeToFile:thumbnailImagePath atomically:YES];
    [UIImageJPEGRepresentation(image, 1.0f) writeToFile:imageFilePath atomically:YES];
    //    UIImage *selfPhoto = [UIImage imageWithContentsOfFile:imageFilePath];//读取图片文件
    //	[userPhotoButton setImage:selfPhoto forState:UIControlStateNormal];
    [[NSUserDefaults standardUserDefaults] setValue:thumbnailImagePath forKey:@"THUMBNAILAVATAR"];
    [[NSUserDefaults standardUserDefaults] setValue:imageFilePath forKey:@"AVATAR"];
    self.model.avatarLocalLocation = imageFilePath;
}

// 改变图像的尺寸，方便上传服务器
- (UIImage*)scaleFromImage:(UIImage*)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//2.保持原来的长宽比，生成一个缩略图
- (UIImage*)thumbnailWithImageWithoutScale:(UIImage*)image size:(CGSize)asize
{
    UIImage* newimage;
    if (nil == image) {
        newimage = nil;
    }
    else {
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width / asize.height > oldsize.width / oldsize.height) {
            rect.size.width = asize.height * oldsize.width / oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width) / 2;
            rect.origin.y = 0;
        }
        else {
            rect.size.width = asize.width;
            rect.size.height = asize.width * oldsize.height / oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height) / 2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height)); //clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}

#pragma mark - Delegate for Editor
- (void)editorDidReturnStr:(NSString*)str
{
    self.model.name = str;
    [self createDataSourceWithModel];
    [[KBUserInfoManager manager] saveUserInfo:self.model];
    [[KBUserInfoManager manager] updateUserName:str andAvatar:nil withCompletion:^(KBBaseModel* model, NSError* error){
        //
    }];
}

@end
