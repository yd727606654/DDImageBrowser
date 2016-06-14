//
//  DDImageBrowerController.m
//  DDImageBrowser
//
//  Created by mac on 16/6/13.
//  Copyright © 2016年 dongdong. All rights reserved.
//

#import "DDImageBrowerController.h"
#import "DDImageBrowerModel.h"
#import "DDCollectionViewCell.h"
#import "DDPresentAnimation.h"
#import "DDDismissAnimation.h"
@interface DDImageBrowerController ()<UICollectionViewDataSource, UICollectionViewDelegate, UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) DDPresentAnimation *presentAnimation;
@property (nonatomic, strong) DDDismissAnimation *dismissAnimation;
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation DDImageBrowerController

static NSString * const reuseIdentifier = @"Cell";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _presentAnimation = [DDPresentAnimation new];
        _dismissAnimation = [DDDismissAnimation new];
        self.transitioningDelegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(self.view.bounds.size.width + cellMargin , self.view.bounds.size.height);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width + cellMargin, self.view.frame.size.height) collectionViewLayout:flowLayout];
    _collection.delegate = self;
    _collection.dataSource = self;
    [_collection registerClass:[DDCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    _collection.pagingEnabled = YES;
    _collection.showsVerticalScrollIndicator = NO;
    [_collection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    [self.view addSubview:_collection];
    
    _pageControl = [[UIPageControl alloc] init];
    CGSize size = [_pageControl sizeForNumberOfPages:self.imageBrowerModels.count];
    _pageControl.frame =CGRectMake((self.view.frame.size.width-size.width)/2, self.view.frame.size.height-size.height-10, size.width, size.height);
    _pageControl.numberOfPages = self.imageBrowerModels.count;
    _pageControl.currentPage = self.currentIndex;
    _pageControl.hidesForSinglePage = YES;
    [self.view addSubview:_pageControl];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tapView) name:DDDismissNotification object:nil];
}

- (void)tapView{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat currentPage = self.collection.contentOffset.x/(self.view.bounds.size.width + cellMargin);
    self.currentIndex = currentPage;
    self.pageControl.currentPage = currentPage;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageBrowerModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DDCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    DDImageBrowerModel *imageBrowerModel = self.imageBrowerModels[indexPath.item];
    cell.imageBrowerModel = imageBrowerModel;
    
    return cell;
}


- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self.presentAnimation;
}
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return  self.dismissAnimation;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
