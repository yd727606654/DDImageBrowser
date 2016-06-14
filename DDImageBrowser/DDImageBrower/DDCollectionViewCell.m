//
//  DDCollectionViewCell.m
//  DDImageBrowser
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 dongdong. All rights reserved.
//

#import "DDCollectionViewCell.h"
#import "DDImageBrowerModel.h"
@interface DDCollectionViewCell ()

@property (nonatomic, strong) DDImageScrollView *imageScrollview;

@end
@implementation DDCollectionViewCell

-(void)setImageBrowerModel:(DDImageBrowerModel *)imageBrowerModel{
    _imageBrowerModel = imageBrowerModel;
    self.imageScrollview.imageModel = imageBrowerModel;
    
    
}

-(DDImageScrollView *)imageScrollview{
    if (!_imageScrollview) {
        _imageScrollview = [[DDImageScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
        [self.contentView addSubview:_imageScrollview];
    }
    return _imageScrollview;
}
@end
