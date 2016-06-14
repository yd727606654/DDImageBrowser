//
//  DDImageBrowerModel.h
//  DDImageBrowser
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 dongdong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
extern CGFloat const cellMargin;
extern NSString * const DDDismissNotification;
@interface DDImageBrowerModel : NSObject

@property (nonatomic, strong) UIImageView *thumImageView;
@property (nonatomic, strong) UIImage *oriImage;
@property (nonatomic, copy) NSString *oriUrl;

@end
