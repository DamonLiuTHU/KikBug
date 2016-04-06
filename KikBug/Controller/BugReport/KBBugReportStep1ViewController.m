//
//  KBBugReportStep1ViewController.m
//  KikBug
//
//  Created by DamonLiu on 16/4/2.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "DNImagePickerController.h"
#import "KBBugManager.h"
#import "KBBugReport.h"
#import "KBBugReportStep1ViewController.h"

@interface KBBugReportStep1ViewController () <UIPickerViewDelegate, DNImagePickerControllerDelegate>
@property (strong, nonatomic) KBBugCategory* category;

@property (strong, nonatomic) UILabel* chooseLabelHint;
@property (strong, nonatomic) UIPickerView* pickerView;
//@property (strong, nonatomic) UIPickerView* severtyPickerView;
@property (strong, nonatomic) UILabel* selectedCategory;
@property (strong, nonatomic) NSArray* severityArray;

@property (copy, nonatomic) NSString* taskId;
@property (copy, nonatomic) NSString* reportId;

@property (strong, nonatomic) UILabel* severityHintLable;
@property (strong, nonatomic) UILabel* severitySelectedLable;

@property (assign, nonatomic) NSInteger selectedCategoryValue;
@property (assign, nonatomic) NSInteger selectedSeverityValue;

@end

@implementation KBBugReportStep1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.selectedCategoryValue = 1;
    self.selectedSeverityValue = 1;
    // Do any additional setup after loading the view.
    self.chooseLabelHint = [UILabel new];
    [self.view addSubview:self.chooseLabelHint];
    self.chooseLabelHint.text = @"Bug类型";
    self.chooseLabelHint.textColor = [UIColor grayColor];

    self.severityHintLable = [UILabel new];
    self.severityHintLable.text = @"严重程度";
    self.severityHintLable.textColor = [UIColor grayColor];

    self.severitySelectedLable = [UILabel new];
    self.severitySelectedLable.text = @"未选择";
    [self.view addSubview:self.severityHintLable];
    [self.view addSubview:self.severitySelectedLable];

    self.severityArray = @[ @"待定", @"较轻", @"一般", @"严重", @"紧急" ];

    self.pickerView = [UIPickerView new];
    self.pickerView.delegate = self;
    [self.view addSubview:self.pickerView];

    self.selectedCategory = [UILabel new];
    [self.view addSubview:self.selectedCategory];
    self.selectedCategory.text = @"未选择";

    [self configNavigationRightButton];
}

- (void)loadData
{
    WEAKSELF;
    [[KBBugManager sharedInstance] getAllBugCategorysWithCompletion:^(KBBugCategory* category, NSError* error) {
        weakSelf.category = category;
        [weakSelf.pickerView reloadAllComponents];
    }];
}

- (void)configNavigationRightButton
{
    UIButton* rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 28)];
    [rightBtn addTarget:self action:@selector(rightBarButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundColor:THEME_COLOR];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setTitle:@"下一步" forState:UIControlStateNormal];

    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    UINavigationItem* navItem = self.navigationItem;
    navItem.rightBarButtonItem = item;
}

- (void)configConstrains
{
    [self.chooseLabelHint autoPinEdgeToSuperviewMargin:ALEdgeLeft];
    [self.chooseLabelHint autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20.0f];

    [self.pickerView autoSetDimension:ALDimensionHeight toSize:200];
    [self.pickerView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];

    [self.selectedCategory autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.chooseLabelHint withOffset:10.0f];
    [self.selectedCategory autoAlignAxis:ALAxisBaseline toSameAxisOfView:self.chooseLabelHint];

    [self.severityHintLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.chooseLabelHint];
    [self.severityHintLable autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.chooseLabelHint withOffset:10.0f];
    [self.severitySelectedLable autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.severityHintLable withOffset:10.0f];
    [self.severitySelectedLable autoAlignAxis:ALAxisBaseline toSameAxisOfView:self.severityHintLable];

    [super updateViewConstraints];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Picker View Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView
{
    return 2;
}
- (NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
    case 0:
        return 5;
        break;
    case 1:
        return self.severityArray.count;
        break;
    default:
        break;
    }
    return 5;
}
- (NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
    case 0: {
        row = row + 1;
        NSString* key = [@"" stringByAppendingString:INT_TO_STIRNG(row)];
        NSDictionary* dic = [[self.category mj_keyValues] valueForKey:@"categories"];
        return [dic valueForKey:key];
    } break;

    case 1: {
        return self.severityArray[row];
    }
    default:
        break;
    }
    return @"Error";
}

- (void)pickerView:(UIPickerView*)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
    case 0: {
        row = row + 1;
        self.selectedCategoryValue = row;
        NSString* key = [@"" stringByAppendingString:INT_TO_STIRNG(row)];
        NSDictionary* dic = [[self.category mj_keyValues] valueForKey:@"categories"];
        NSString* type = [dic valueForKey:key];
        self.selectedCategory.text = type;
    } break;

    case 1: {
        self.severitySelectedLable.text = self.severityArray[row];
        self.selectedSeverityValue = row + 1;
    }
    default:
        break;
    }
}

#pragma mark - Right bar btn pressed
- (void)rightBarButtonPressed
{
    DNImagePickerController* imagePicker = [[DNImagePickerController alloc] init];
    imagePicker.imagePickerDelegate = self;
    imagePicker.filterType = DNImagePickerFilterTypePhotos;
    //    [imagePicker showAlbumList];
    [self presentViewController:imagePicker animated:YES completion:^{
        //
    }];
}

#pragma mark - DNImagePickerControllerDelegate

- (void)dnImagePickerController:(DNImagePickerController*)imagePickerController sendImages:(NSArray<DNAsset*>*)imageAssets isFullImage:(BOOL)fullImage
{
    WEAKSELF;
    KBBugReport* report = [KBBugReport reportWithDNAssets:imageAssets taskId:self.taskId];
    report.severity = self.selectedSeverityValue;
    report.bugCategoryId = self.selectedCategoryValue;
    //    [[KBBugManager sharedInstance] uploadBugReport:report withCompletion:^(KBBaseModel* model, NSError* error) {
    [[KBBugManager sharedInstance] uploadBugReportWithReportId:self.reportId reportd:report withCompletion:^(KBBaseModel* model, NSError* error) {
        if (!error) {
            [weakSelf showHudViewWithText:@"Bug上传成功"];
        }
        else {
        }
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dnImagePickerControllerDidCancel:(DNImagePickerController*)imagePicker
{
    [imagePicker dismissViewControllerAnimated:YES completion:^{

    }];
}

#pragma mark - params
- (void)setParams:(NSDictionary*)params
{
    self.taskId = params[@"taskId"];
    self.reportId = params[@"reportId"];
}

@end
