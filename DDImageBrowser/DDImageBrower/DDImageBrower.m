//
//  DDImageBrower.m
//  DDImageBrowser
//
//  Created by mac on 16/3/10.
//  Copyright © 2016年 dongdong. All rights reserved.
//

#import "DDImageBrower.h"
#import "DDImageBrowerModel.h"


@interface DDImageBrower()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) NSMutableArray *DDImageBrowerModels;
@end

@implementation DDImageBrower

+ (void)showImageUrls:(NSArray *)imageUrls OriImageViews:(NSArray *)oriImageViews Index:(int)index{
    
  DDImageBrower *brower = [[self alloc] initWithFrame:[UIScreen mainScreen].bounds];
    for (int i = 0; i < imageUrls.count; i++) {
        DDImageBrowerModel *browerModel = [[DDImageBrowerModel alloc] init];
        
        browerModel.thumImage =
    }
    
    UIWindow *window=[UIApplication sharedApplication].keyWindow;

    [window addSubview:brower];
 
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutViews];
    }
    return self;
}

- (void)layoutViews
{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = self.bounds.size;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collection = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:flowLayout];
    _collection.delegate = self;
    _collection.dataSource = self;
    [self addSubview:_collection];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.DDImageBrowerModels.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end











