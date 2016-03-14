//
//  DDCollectionViewCell.h
//  DDImageBrowser
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 dongdong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDImageScrollView.h"
@interface DDCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) DDImageScrollView *imageScrollview;
@end
