//
//  KBSegmentSelectView.m
//  KikBug
//
//  Created by DamonLiu on 16/4/19.
//  Copyright © 2016年 DamonLiu. All rights reserved.
//

#import "KBSegmentSelectView.h"
#import "KBSegmentControlCell.h"

@interface KBSegmentSelectView ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, weak) UICollectionView *collectionMain;
@property (nonatomic, weak) UIView *line;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic ,strong) NSArray *itemsArray;
@property (nonatomic, assign) int index;
@property (nonatomic,assign) int lastPositionX;
@property (nonatomic,assign) BOOL scrollToRight;
@end
static NSString *mainCell = @"KBSegmentControlCell";
@implementation KBSegmentSelectView


#define CollectionWidth (SCREEN_Width - 120)
#define SCREEN_Width ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_Height ([[UIScreen mainScreen] bounds].size.height)

- (instancetype)initWithDelegate:(id<KBSegmentSelectViewDelegate>)delegate titles:(NSArray *)titles
{
    if (self = [super init]) {
        self.delegate = delegate;
        self.backgroundColor = THEME_COLOR;
        self.itemsArray = titles;
        [self addCollectionMain];
    }
    return self;
}

- (void)configButtonsWithTitle:(NSString *)titles
{
    
}

- (void)addCollectionMain{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionMain = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionMain.dataSource = self;
    collectionMain.delegate = self;
    collectionMain.pagingEnabled = YES;
    collectionMain.scrollEnabled = YES;
    collectionMain.bounces = NO;
    collectionMain.showsHorizontalScrollIndicator = NO;
    [collectionMain registerClass:[KBSegmentControlCell class] forCellWithReuseIdentifier:mainCell];
    [self addSubview:collectionMain];
    [self bringSubviewToFront:collectionMain];
    self.collectionMain = collectionMain;
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor redColor];
    self.lineWidth = self.frame.size.width / self.itemsArray.count;
    [self addSubview:line];
    [self bringSubviewToFront:line];
    self.line = line;
    
    
    [self.line autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.line autoSetDimension:ALDimensionHeight toSize:3.0f];
    [self.line autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self];
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return collectionView.frame.size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.itemsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KBSegmentControlCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:mainCell forIndexPath:indexPath];
//    [cell setIndexController:self.controllers[indexPath.row]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionMain scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    if (self.delegate) {
        [self.delegate didSelectIndex:indexPath.row];
        
    }
    
    [UIView animateWithDuration:0.25 animations:^{
//        self.line.frame = CGRectMake((0 + indexPath.row) * self.lineWidth, self.pageBarHeight - 3, self.lineWidth, 3);
        [self.line autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:indexPath.row * self.lineWidth];
        [self updateConstraints];
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat x = scrollView.contentOffset.x ;
    int index = (x + SCREEN_Width * 0.5) / SCREEN_Width;
    [UIView animateWithDuration:0.25 animations:^{
//        self.line.frame = CGRectMake(index *self.lineWidth, self.pageBarHeight - 3, self.lineWidth, 3);
        [self.line autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:index * self.lineWidth];
    }];
    self.index = index;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int currentPostion = scrollView.contentOffset.x;
    if (currentPostion - _lastPositionX > 5) {
        _scrollToRight = YES;
    }else if(currentPostion - _lastPositionX < -5){
        _scrollToRight = NO;
    }
    _lastPositionX = currentPostion;
}


@end
