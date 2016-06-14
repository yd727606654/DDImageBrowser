//
//  DDCollectionViewCell.h
//  DDImageBrowser
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 dongdong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDImageScrollView.h"
@class DDImageBrowerModel;
@interface DDCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) DDImageBrowerModel *imageBrowerModel;
@end
