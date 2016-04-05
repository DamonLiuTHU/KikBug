//
//  KBImageBrowser.m
//  KikBug
//
//  Created by DamonLiu on 16/4/2.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBImageBrowser.h"
#import "KBImageBrowserCell.h"

@interface KBImageBrowser ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView* browserCollectionView;
@property (nonatomic, strong) NSArray<NSString *> *imgUrls;
@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation KBImageBrowser
{
//    BOOL _statusBarShouldBeHidden;
//    BOOL _didSavePreviousStateOfNavBar;
    BOOL _viewIsActive;
    BOOL _viewHasAppearedInitially;
    BOOL _didSavePreviousStateOfNavBar;
    // Appearance
    BOOL _previousNavBarHidden;
    BOOL _previousNavBarTranslucent;
    UIBarStyle _previousNavBarStyle;
    UIStatusBarStyle _previousStatusBarStyle;
    UIColor* _previousNavBarTintColor;
    UIColor* _previousNavBarBarTintColor;
    UIBarButtonItem* _previousViewControllerBackButton;
    UIImage* _previousNavigationBarBackgroundImageDefault;
    UIImage* _previousNavigationBarBackgroundImageLandscapePhone;
}

- (instancetype)initWithImageUrls:(NSArray<NSString *> *)urls
{
    if (self = [super init]) {
        self.imgUrls = urls;
        
        if (nil == _browserCollectionView) {
            UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
            layout.minimumInteritemSpacing = 0;
            layout.minimumLineSpacing = 0;
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
           
            _browserCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
            _browserCollectionView.backgroundColor = [UIColor blackColor];
            _browserCollectionView.delegate = self;
            _browserCollectionView.dataSource = self;
            _browserCollectionView.pagingEnabled = YES;
            _browserCollectionView.showsHorizontalScrollIndicator = NO;
            _browserCollectionView.showsVerticalScrollIndicator = NO;
            [self.browserCollectionView registerClass:[KBImageBrowserCell class] forCellWithReuseIdentifier:@"KBImageBrowserCell"];
            [self.view addSubview:_browserCollectionView];
        }

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.browserCollectionView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    
    // Super
    [super viewWillAppear:animated];
    _previousStatusBarStyle = [[UIApplication sharedApplication] statusBarStyle];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:animated];
    
    // Navigation bar appearance
    if (!_viewIsActive && [self.navigationController.viewControllers objectAtIndex:0] != self) {
        [self storePreviousNavBarAppearance];
    }
    [self setNavBarAppearance:animated];
    
    // Initial appearance
    if (!_viewHasAppearedInitially) {
        _viewHasAppearedInitially = YES;
    }
    
    //scroll to the current offset
    [self.browserCollectionView setContentOffset:CGPointMake(self.browserCollectionView.frame.size.width * self.currentIndex, 0)];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // Check that we're being popped for good
    if ([self.navigationController.viewControllers objectAtIndex:0] != self && ![self.navigationController.viewControllers containsObject:self]) {
        
        _viewIsActive = NO;
        [self restorePreviousNavBarAppearance:animated];
    }
    
    [self.navigationController.navigationBar.layer removeAllAnimations];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];

    
    [[UIApplication sharedApplication] setStatusBarStyle:_previousStatusBarStyle animated:animated];
    
    // Super
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _viewIsActive = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    _viewIsActive = NO;
    [super viewDidDisappear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configConstrains
{
    [self.browserCollectionView autoPinEdgesToSuperviewEdges];
    
    
    [super updateViewConstraints];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.imgUrls count];
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    KBImageBrowserCell *cell = (KBImageBrowserCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"KBImageBrowserCell" forIndexPath:indexPath];
    NSString *imgUrl = self.imgUrls[indexPath.row];
//    UIImageView *imageView = [UIImageView new];
//    [imageView setImageWithUrl:imgUrl];
//    [cell addSubview:imageView];
//    [imageView autoPinEdgesToSuperviewEdges];
    [cell bindModel:imgUrl];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath
{
    return CGSizeMake(self.view.bounds.size.width , self.view.bounds.size.height);
}

#pragma mark - scrollerViewDelegate
- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
//    CGFloat offsetX = scrollView.contentOffset.x;
//    CGFloat itemWidth = CGRectGetWidth(self.browserCollectionView.frame);
//    CGFloat currentPageOffset = itemWidth * self.currentIndex;
//    CGFloat deltaOffset = offsetX - currentPageOffset;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat itemWidth = CGRectGetWidth(self.browserCollectionView.frame);
    if (offsetX >= 0) {
        NSInteger page = offsetX / itemWidth;
        [self didScrollToPage:page];
    }
}

- (void)didScrollToPage:(NSInteger)page
{
    self.currentIndex = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView*)scrollView
{
    
}

#pragma - params
-(void)setParams:(NSDictionary *)params
{
    self.imgUrls = params[@"imgUrls"];
}

#pragma mark - Nav Bar Appearance
- (void)setNavBarAppearance:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:YES];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    UINavigationBar* navBar = self.navigationController.navigationBar;
    navBar.tintColor = [UIColor whiteColor];
    if ([navBar respondsToSelector:@selector(setBarTintColor:)]) {
        navBar.barTintColor = nil;
        navBar.shadowImage = nil;
    }
    navBar.translucent = YES;
    navBar.barStyle = UIBarStyleBlackTranslucent;
    if ([[UINavigationBar class] respondsToSelector:@selector(appearance)]) {
        [navBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        [navBar setBackgroundImage:nil forBarMetrics:UIBarMetricsCompact];
    }
}

- (void)storePreviousNavBarAppearance
{
    _didSavePreviousStateOfNavBar = YES;
    if ([UINavigationBar instancesRespondToSelector:@selector(barTintColor)]) {
        _previousNavBarBarTintColor = self.navigationController.navigationBar.barTintColor;
    }
    _previousNavBarTranslucent = self.navigationController.navigationBar.translucent;
    _previousNavBarTintColor = self.navigationController.navigationBar.tintColor;
    _previousNavBarHidden = self.navigationController.navigationBarHidden;
    _previousNavBarStyle = self.navigationController.navigationBar.barStyle;
    if ([[UINavigationBar class] respondsToSelector:@selector(appearance)]) {
        _previousNavigationBarBackgroundImageDefault = [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
        _previousNavigationBarBackgroundImageLandscapePhone = [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsCompact];
    }
}

- (void)restorePreviousNavBarAppearance:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
    if (_didSavePreviousStateOfNavBar) {
        [self.navigationController setNavigationBarHidden:_previousNavBarHidden animated:animated];
        UINavigationBar* navBar = self.navigationController.navigationBar;
        navBar.tintColor = _previousNavBarTintColor;
        navBar.translucent = _previousNavBarTranslucent;
        if ([UINavigationBar instancesRespondToSelector:@selector(barTintColor)]) {
            navBar.barTintColor = _previousNavBarBarTintColor;
        }
        navBar.barStyle = _previousNavBarStyle;
        if ([[UINavigationBar class] respondsToSelector:@selector(appearance)]) {
            [navBar setBackgroundImage:_previousNavigationBarBackgroundImageDefault forBarMetrics:UIBarMetricsDefault];
            [navBar setBackgroundImage:_previousNavigationBarBackgroundImageLandscapePhone forBarMetrics:UIBarMetricsCompact];
        }
        // Restore back button if we need to
        if (_previousViewControllerBackButton) {
            UIViewController* previousViewController = [self.navigationController topViewController]; // We've disappeared so previous is now top
            previousViewController.navigationItem.backBarButtonItem = _previousViewControllerBackButton;
            _previousViewControllerBackButton = nil;
        }
    }
}



@end
